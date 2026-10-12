-- Render theme previews for `theme preview`. Runs in headless Neovim with the
-- full config, so each colorscheme looks exactly as it does when applied.
-- Input:  THEME_PREVIEW_SPECS, one "label|ghostty theme|colorscheme|background"
--         per line. THEME_PREVIEW_OUT, the file to write the ANSI text to.
-- Also loaded as a module (THEME_PREVIEW_SPECS unset) for M.colors().
local M = {}

local GHOSTTY_DIRS = {
  (vim.env.XDG_CONFIG_HOME or vim.fn.expand("~/.config")) .. "/ghostty/themes",
  "/Applications/Ghostty.app/Contents/Resources/ghostty/themes",
}

-- Sample buffer. Each token names the highlight groups to try, in order.
local G = {
  comment = { "@comment", "Comment" },
  keyword = { "@keyword", "Keyword", "Statement" },
  kwfunc = { "@keyword.function", "@keyword", "Keyword", "Statement" },
  cond = { "@keyword.conditional", "Conditional", "Statement" },
  ret = { "@keyword.return", "@keyword", "Statement" },
  func = { "@function", "Function" },
  call = { "@function.call", "@function", "Function" },
  str = { "@string", "String" },
  const = { "@constant.builtin", "@boolean", "Constant" },
  num = { "@number", "Number", "Constant" },
  builtin = { "@variable.builtin", "@module.builtin", "Identifier" },
  plain = { "@variable", "Normal" },
}
local CODE = {
  { { "comment", "-- open a scratch buffer in a split" } },
  { { "kwfunc", "local function " }, { "func", "open_scratch" }, { "plain", "(name)" } },
  { { "plain", "  " }, { "keyword", "local " }, { "plain", "buf = " }, { "builtin", "vim" }, { "plain", ".api." },
    { "call", "nvim_create_buf" }, { "plain", "(" }, { "const", "false" }, { "plain", ", " }, { "const", "true" }, { "plain", ")" } },
  { { "plain", "  " }, { "builtin", "vim" }, { "plain", ".bo[buf].filetype = " }, { "str", '"markdown"' } },
  { { "plain", "  " }, { "cond", "if " }, { "plain", "name ~= " }, { "const", "nil" }, { "cond", " then" } },
  { { "plain", "    " }, { "builtin", "vim" }, { "plain", ".api." }, { "call", "nvim_buf_set_name" }, { "plain", "(buf, name)" } },
  { { "plain", "  " }, { "cond", "end" } },
  { { "plain", "  " }, { "ret", "return " }, { "plain", "buf, " }, { "num", "42" } },
  { { "kwfunc", "end" } },
}
local CURSOR = 3
local WIDTH = 64

-- xterm 256-color index to hex, for schemes that only set cterm colors.
local function xterm(i)
  if not i then return nil end
  local base = { 0x000000, 0x800000, 0x008000, 0x808000, 0x000080, 0x800080, 0x008080, 0xc0c0c0,
    0x808080, 0xff0000, 0x00ff00, 0xffff00, 0x0000ff, 0xff00ff, 0x00ffff, 0xffffff }
  if i < 16 then return base[i + 1] end
  if i >= 232 then local v = 8 + (i - 232) * 10; return v * 0x10101 end
  i = i - 16
  local function c(n) return n == 0 and 0 or 55 + n * 40 end
  return c(math.floor(i / 36)) * 0x10000 + c(math.floor(i / 6) % 6) * 0x100 + c(i % 6)
end

local function hl(names)
  for _, name in ipairs(names) do
    local h = vim.api.nvim_get_hl(0, { name = name, link = false })
    local fg = h.fg or xterm(h.ctermfg)
    local bg = h.bg or xterm(h.ctermbg)
    if h.reverse then fg, bg = bg, fg end
    if fg or bg or h.bold then return { fg = fg, bg = bg, bold = h.bold or false } end
  end
  return {}
end

-- Colors of the current colorscheme, as 0xRRGGBB numbers (nil when unset).
function M.colors()
  local c = { normal = hl({ "Normal" }), groups = {} }
  for k, names in pairs(G) do c.groups[k] = hl(names) end
  c.linenr = hl({ "LineNr" })
  c.cursorline = hl({ "CursorLine" })
  c.cursorlinenr = hl({ "CursorLineNr", "LineNr" })
  c.statusline = hl({ "StatusLine" })
  c.background = vim.o.background
  return c
end

function M.ghostty(name)
  for _, dir in ipairs(GHOSTTY_DIRS) do
    local ok, lines = pcall(vim.fn.readfile, dir .. "/" .. name)
    if ok then
      local t = { palette = {} }
      for _, line in ipairs(lines) do
        local i, hex = line:match("^%s*palette%s*=%s*(%d+)%s*=%s*#?(%x+)")
        if i then t.palette[tonumber(i)] = tonumber(hex, 16) end
        local k, v = line:match("^%s*(%a+)%s*=%s*#?(%x%x%x%x%x%x)%s*$")
        if k == "background" or k == "foreground" then t[k] = tonumber(v, 16) end
      end
      return t
    end
  end
end

local ESC = string.char(27)
local function rgb(n) return math.floor(n / 0x10000), math.floor(n / 0x100) % 0x100, n % 0x100 end
local function sgr(fg, bg, bold)
  local s = ESC .. "[0"
  if bold then s = s .. ";1" end
  if fg then s = s .. (";38;2;%d;%d;%d"):format(rgb(fg)) end
  if bg then s = s .. (";48;2;%d;%d;%d"):format(rgb(bg)) end
  return s .. "m"
end
local RESET = ESC .. "[0m"

-- One row: segments of { text, fg, bg, bold }, padded to WIDTH with pad_bg.
local function row(segs, pad_bg)
  local out, len = { "  " }, 0
  for _, s in ipairs(segs) do
    out[#out + 1] = sgr(s[2], s[3], s[4]) .. s[1]
    len = len + vim.fn.strdisplaywidth(s[1])
  end
  out[#out + 1] = sgr(nil, pad_bg) .. string.rep(" ", math.max(0, WIDTH - len)) .. RESET
  return table.concat(out)
end

function M.render(label, ghostty_name, c, gt)
  local bg = c.normal.bg or (gt and gt.background) or (c.background == "light" and 0xffffff or 0x000000)
  local fg = c.normal.fg or (gt and gt.foreground) or (c.background == "light" and 0x000000 or 0xffffff)
  local lines = { "", "  " .. sgr(nil, nil, true) .. label .. RESET .. ESC .. "[2m  ghostty: " .. ghostty_name .. RESET }
  for i, toks in ipairs(CODE) do
    local cur = i == CURSOR
    local lbg = cur and c.cursorline.bg or bg
    local nr = cur and c.cursorlinenr or c.linenr
    local segs = { { ("%3d "):format(i), nr.fg or fg, nr.bg or lbg, nr.bold } }
    for _, t in ipairs(toks) do
      local g = c.groups[t[1]]
      segs[#segs + 1] = { t[2], g.fg or fg, g.bg or lbg, g.bold }
    end
    lines[#lines + 1] = row(segs, lbg)
  end
  local sl = c.statusline
  lines[#lines + 1] = row({ { " NORMAL  lua/scratch.lua", sl.fg or bg, sl.bg or fg, sl.bold } }, sl.bg or fg)
  -- The shell and ANSI palette come from Ghostty, not Neovim.
  local p = gt and gt.palette or {}
  local tbg = gt and gt.background or bg
  local tfg = gt and gt.foreground or fg
  lines[#lines + 1] = row({ { "~/projects ", p[4] or tfg, tbg }, { "main", p[8] or tfg, tbg } }, tbg)
  lines[#lines + 1] = row({ { "$ ", tfg, tbg }, { "git status", tfg, tbg } }, tbg)
  local sw = {}
  for i = 0, 15 do sw[#sw + 1] = { "    ", nil, p[i] or tbg } end
  lines[#lines + 1] = row(sw, tbg)
  return table.concat(lines, "\n")
end

local specs = vim.env.THEME_PREVIEW_SPECS
if specs then
  local out = {}
  for line in specs:gmatch("[^\n]+") do
    local label, gname, scheme, bgmode = unpack(vim.split(line, "|", { plain = true }))
    vim.o.background = bgmode
    if pcall(vim.cmd.colorscheme, scheme) then
      out[#out + 1] = M.render(label, gname, M.colors(), M.ghostty(gname))
    else
      out[#out + 1] = "\n  " .. label .. ": colorscheme '" .. scheme .. "' failed to load"
    end
  end
  vim.fn.writefile(vim.split(table.concat(out, "\n") .. "\n", "\n"), vim.env.THEME_PREVIEW_OUT)
end

return M
