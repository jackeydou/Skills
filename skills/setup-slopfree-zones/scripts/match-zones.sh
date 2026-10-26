#!/usr/bin/env bash
# List the tracked files each slopfree pattern matches, so a pattern can be checked before it is
# written and after. Patterns are git glob pathspecs, one per line; blank lines and # comments are
# skipped, the same way the commit check in AGENTS.md reads .slopfree.
#
#   match-zones.sh [-C repo] [-n max-files-shown] [patterns-file | -]
#
# The patterns file defaults to .slopfree at the repo root; `-` reads patterns from stdin.
# Exit status is 1 when any pattern matches no tracked file.
set -euo pipefail

repo=.
max=5
while getopts "C:n:" opt; do
  case $opt in
    C) repo=$OPTARG ;;
    n) max=$OPTARG ;;
    *) echo "usage: $0 [-C repo] [-n max] [patterns-file | -]" >&2; exit 2 ;;
  esac
done
shift $((OPTIND - 1))

root=$(git -C "$repo" rev-parse --show-toplevel)
src=${1:-$root/.slopfree}
if [ "$src" = - ]; then src=/dev/stdin; fi
[ -e "$src" ] || { echo "no patterns file: $src" >&2; exit 2; }

empty=0
total=0
while IFS= read -r line || [ -n "$line" ]; do
  pattern=$(printf '%s' "$line" | sed -E 's/^[[:space:]]+//; s/[[:space:]]+$//')
  case $pattern in '' | '#'*) continue ;; esac
  case $pattern in
    *[[:space:]]*) echo "!! $pattern  (contains whitespace; the commit check splits on it)"; empty=1; continue ;;
  esac
  files=$(git -C "$root" ls-files -- ":(glob)$pattern")
  if [ -z "$files" ]; then
    echo "0  $pattern  (matches no tracked file)"
    empty=1
    continue
  fi
  count=$(printf '%s\n' "$files" | wc -l | tr -d ' ')
  total=$((total + count))
  echo "$count  $pattern"
  printf '%s\n' "$files" | head -n "$max" | sed 's/^/     /'
  if [ "$count" -gt "$max" ]; then echo "     ... $((count - max)) more"; fi
done < "$src"

echo "-- $total tracked files in zones"
exit $empty
