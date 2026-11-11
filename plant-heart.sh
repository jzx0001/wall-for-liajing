#!/usr/bin/env bash
# Pixel wall: plant a heart on the contribution graph (the wall is hers).
set -e
git config user.name "jzx0001"
git config user.email "62313743+jzx0001@users.noreply.github.com"
ROWS=(
".##...##."
"#########"
"#########"
".#######."
"..#####.."
"...###..."
"....#...."
)
OFF=21
PER_CELL=5
EPOCH_SUN=$(TZ=Asia/Shanghai date -d "$(TZ=Asia/Shanghai date +%F) -$(TZ=Asia/Shanghai date +%w) days" +%s)
LEFT=$((EPOCH_SUN - 51 * 7 * 86400))
for y in 0 1 2 3 4 5 6; do
  row="${ROWS[$y]}"
  for ((x = 0; x < ${#row}; x++)); do
    if [ "${row:$x:1}" = "#" ]; then
      col=$((OFF + x))
      day=$((LEFT + (col * 7 + y) * 86400))
      datestr=$(TZ=Asia/Shanghai date -d "@$day" +%F)
      for ((i = 1; i <= PER_CELL; i++)); do
        GIT_AUTHOR_DATE="${datestr}T12:0${i}:00+08:00" GIT_COMMITTER_DATE="${datestr}T12:0${i}:00+08:00" git commit --allow-empty -q -m "heart"
      done
    fi
  done
done
git push origin HEAD
echo "planted"
