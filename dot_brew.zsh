# Send package changes through brewfile, so ~/.Brewfile stays the complete
# list. Every other brew command runs unchanged.
# To bypass this function, run `command brew ...`.
#
# Homebrew runs `gh` with its own PATH, which leaves out ~/.local/bin, so it
# cannot get a GitHub token for attestation checks. Pass the token in for
# each brew run. It is never written to disk.
brew() {
  case ${1-} in
    install)
      shift; brewfile add "$@" ;;
    uninstall|remove|rm)
      shift; brewfile remove "$@" ;;
    tap|untap)
      print -u2 "brew $1: taps are not allowed. To bypass, run: command brew $*"
      return 1 ;;
    fetch)
      # fetch caches bottles without an attestation check, and a later
      # install from that cache skips the check.
      print -u2 "brew fetch: blocked, it skips attestation checks. To bypass, run: command brew $*"
      return 1 ;;
    *)
      local token=${HOMEBREW_GITHUB_API_TOKEN-}
      [[ -z $token ]] && (( $+commands[gh] )) && token=$(gh auth token --hostname github.com 2>/dev/null)
      HOMEBREW_GITHUB_API_TOKEN=$token command brew "$@" ;;
  esac
}
