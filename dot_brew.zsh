# Send package changes through brewfile, so ~/.Brewfile stays the complete
# list. Every other brew command runs unchanged.
# To bypass this function, run `command brew ...`.
brew() {
  case ${1-} in
    install)
      shift; brewfile add "$@" ;;
    uninstall|remove|rm)
      shift; brewfile remove "$@" ;;
    tap|untap)
      print -u2 "brew $1: taps are not allowed. To bypass, run: command brew $*"
      return 1 ;;
    *)
      command brew "$@" ;;
  esac
}
