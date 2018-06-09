#!/usr/bin/env python3

import os
import sys



class Status:
    def created(name):
        print("[\033[1;34;34m*\033[0m] Created: %s" % name)

    def badFilename(name):
        print("[\033[1;31;31m-\033[0m] Bad Filename: %s" % name)

    def accessDenied(path):
        print("[\033[1;31;31m-\033[0m] Directory not writable: %s" % path + "/")



class Component:
    def __init__(self, name):
        self.name    = self.getName(name)
        self.dirPath = self.name
        self.jsxPath = self.name + "/" + self.name + ".jsx"
        self.cssPath = self.name + "/" + self.name + ".css"

    def create(self):
        if not os.path.isdir(self.name):
            os.makedirs(self.name)
            Status.created(self.name + "/")
        else:
            if not os.access(self.name, os.W_OK):
                Status.accessDenied(self.name)
                quit(1)

        if not os.path.isfile(self.jsxPath):
            with open(self.jsxPath, "a") as file:
                file.write(self.getJsx())
                file.close()
                Status.created(self.jsxPath)

        if not os.path.isfile(self.cssPath):
            with open(self.cssPath, "a") as file:
                file.write(self.getCss())
                file.close()
                Status.created(self.cssPath)

    def getName(self, name):
        if (name[0].islower()):
            name = name[0].upper() + name[1::]

        return name

    def getCss(self):
        return (".%s {\n\n"
                "}\n" % self.name)

    def getJsx(self):
        return ("import React from 'react';\n\n"
                "import './%s.css';\n\n"
                "class %s extends React.Component {\n"
                "    render() {\n"
                "        return (\n"
                "            <div className=\"%s\"></div>\n"
                "        );\n"
                "    }\n"
                "}\n\n"
                "export default %s;\n" % (self.name, self.name, self.name, self.name))



if not os.access(os.getcwd(), os.W_OK):
    Status.accessDenied("/")
    quit(1)

for arg in sys.argv[1::]:
    if "/" in arg:
        Status.badFilename(arg)
    else:
        Component(arg).create();
