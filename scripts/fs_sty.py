#!/usr/bin/env python

import os
import re
from sys import argv

scripts, css = argv


# filter icon name, ignore alias
def fil_icname(line):
    if re.search('^\.fa-.*:before {$', line):
        ic_name = re.split("[.:]", line)[1][3:]
        return ic_name


def fil_iccode(line):
    if re.search('^  content: .*;$', line):
        ic_code = re.split("[\"]", line)[1][1:].upper()
        return ic_code


# turn icon name to Camel Case
# forked from https://github.com/schischi-a/fontawesome-latex
def camel_case(name):
    ret = name.replace('-', ' ')
    ret = ret.title()
    ret = ret.replace(' ', '')
    return ret


def get_icons(fs_css):
    icons = []
    with open(fs_css, 'r') as fs_fp:
        for line in fs_fp:
            icon_name = fil_icname(line)
            if icon_name is not None:
                line = next(fs_fp)
                icon_code = fil_iccode(line)
                if icon_code is not None:
                    tex_name = camel_case(icon_name)
                    icons.append((icon_name, icon_code, tex_name))
    return icons


def output_sty(sty, icons):
    with open(sty, 'a') as f:
        for ic in icons:
            prefix = "\expandafter\def\csname faicon@"
            ic_name_h = prefix + ic[0] + "\endcsname"
            ic_code_tex = "{\symbol{\"" + ic[1] + "}}  \\def\\fa" + ic[2]
            ic_name_tail = " {{\FA\csname faicon@" + ic[0] + "\endcsname}}\n"
            f.write(ic_name_h.ljust(63) + ic_code_tex.ljust(42) + ic_name_tail)


if __name__ == "__main__":
    print("output fontawesome.sty...")
    icons = get_icons(css)
    temp_dir = os.path.dirname(css)
    sty = os.path.join(temp_dir, "fontawesome.sty")
    output_sty(sty, icons)
