#!/bin/bash

# Usage: 
# 将下列内容加入~/.gitconfig
#####
# [diff]
# 	tool = araxis
# [difftool "araxis"]
#	cmd = ~/bin/araxis.sh "$LOCAL" "$REMOTE"
# [merge]
#	tool = araxis
# [mergetool "araxis"]
#	cmd = ~/bin/araxis.sh "$LOCAL" "$REMOTE" "$BASE" "$MERGED"
#	trustExitCode = true
#####


# 转换每个参数为 Windows 路径
args=()
for arg in "$@"; do
	args+=("$(wslpath -w "$arg")")
done

# 调用 Araxis Merge，传入转换后的参数
"/mnt/d/Program Files/Araxis/Araxis Merge/Merge.exe" "${args[@]}"

