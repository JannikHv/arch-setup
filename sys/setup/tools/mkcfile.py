#!/usr/bin/env python3

from os.path import isfile as isFile
from sys     import argv

def buildHeaderFile(filename):
    name = filename.upper().replace("-", "_")

    content = ("#ifndef __"   + name + "_H" + "__\n"
              +"#define __"   + name + "_H" + "__\n\n"
              +"#endif /* __" + name + "_H" + "__ */\n\n"
              + """/*
 * Editor modelines  -  https://www.wireshark.org/tools/modelines.html
 *
 * Local variables:
 * c-basic-offset: 8
 * tab-width: 8
 * indent-tabs-mode: nil
 * End:
 *
 * vi: set shiftwidth=8 tabstop=8 expandtab:
 * :indentSize=8:tabSize=8:noTabs=true:
 */""")

    with open(filename + ".h", "w+") as f:
        f.write(content)
        f.close()

    print("[\033[1;32;32m+\033[0m] File created: " + filename + ".h")

def buildSourceFile(filename):
    content = ("#include \"" + filename + ".h\"\n\n"
	      + """/*
 * Editor modelines  -  https://www.wireshark.org/tools/modelines.html
 *
 * Local variables:
 * c-basic-offset: 8
 * tab-width: 8
 * indent-tabs-mode: nil
 * End:
 *
 * vi: set shiftwidth=8 tabstop=8 expandtab:
 * :indentSize=8:tabSize=8:noTabs=true:
 */""")

    with open(filename + ".c", "w+") as f:
        f.write(content)
        f.close()

    print("[\033[1;32;32m+\033[0m] File created: " + filename + ".c")

for name in argv:
    if name is argv[0]:
        continue

    if isFile(name + ".h"):
        print("[\033[1;31;31m-\033[0m] File exists:  " + name + ".h")
    else:
        buildHeaderFile(name)

    if isFile(name + ".c"):
        print("[\033[1;31;31m-\033[0m] File exists:  " + name + ".c")
    else:
        buildSourceFile(name)
