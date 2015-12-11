#!/bin/sh

script_root=$(dirname $0)
resume_root=$(dirname "${script_root}")
temp_root='/tmp/fs_script'
fs_src="${temp_root}/fontawesome"

[ -r "$fs_src" ] && $(rm -rf "$fs_src")
mkdir -p $fs_src

cp "$script_root/fs_sty.py" "$temp_root"
cp "$script_root/fontawesome_preamble.sty" "$temp_root/fontawesome.sty"

git clone -b v4.5.0 --depth 1 https://github.com/FortAwesome/Font-Awesome.git $fs_src
cp "${fs_src}/css/font-awesome.css" "${temp_root}/fontawesome.css"
cp "${fs_src}/fonts/fontawesome-webfont.ttf" "${resume_root}/fonts/fontawesome-webfont.ttf"
python "${temp_root}/fs_sty.py" "${temp_root}/fontawesome.css"
cp "${temp_root}/fontawesome.sty" "${resume_root}"
cat "${resume_root}/scripts/fontawesome_tail.sty" >> "${resume_root}/fontawesome.sty"
