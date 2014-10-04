from __future__ import print_function
from PIL import Image
from os import walk
from colorama import init
import yaml
from shutil import copy, copytree, rmtree
from os.path import isdir
from os import rename, mkdir
import fileinput

def process(description):
    print("\033[2;47;30m" + description + "\033[1;49m")

def task(*terms):
    print ("\t", end="")
    for i in range(0,len(terms)):
        print(("\033[37m" if (i % 2 == 0) else "\033[33m") + terms[i], end="")
        if (i < len(terms)): print (" ", end="")
    print("\t\t", end="")

def critical(description):
    print("\033[41;31m  CRITICAL  \033[49m " + description)

def skip(description):
    print("\033[46;36m  SKIP  \033[49m " + description)

def ok():
    print("\033[32mOk!")

init()
definition = yaml.load(open('../definition.yaml', 'r'))

print("\n\033[1mGenerating project " + "\033[33m" + definition["GameName"] +
      " \033[2m(" + definition["GameID"] + ")" + 
      " \033[2;36m\"" + definition["GameDescription"] + "\"")
print("\033[1;37m\tFrom developer " + "\033[32m" + definition["DeveloperName"] +
      " \033[2m" + definition["DeveloperURL"])
print("\033[1m")

process("Copying Project...")
task("Copying","source","to","build")
try:
    if (isdir("..\\build")): rmtree("..\\build")
    copytree("..\\source", "..\\build")
except Exception as e: critical(e.args[1])
else: ok()

process("Generating icon images...")

task("Creating folder", "icons")
try:
    mkdir("..\\build\icons")
except Exception as e: critical(e.args[1])
else: ok()

task("Opening Image", definition["DeveloperLogo"])
try:
    im = Image.open("..\\" + definition["DeveloperLogo"])
except Exception as e: critical(e.args[1])
else: ok()

task("Generating","144x144","image")
try:
    out = im.resize((144, 144),Image.ANTIALIAS)
    out.save("..\\build\\icons\\144x144.png")
except Exception as e: critical(e.args[1])
else: ok()

task("Generating","128x128","image")
try:
    out = im.resize((128, 128),Image.ANTIALIAS)
    out.save("..\\build\\icons\\128x128.png")
except Exception as e: critical(e.args[1])
else: ok()

task("Generating","114x114","image")
try:
    out = im.resize((114, 114),Image.ANTIALIAS)
    out.save("..\\build\\icons\\114x114.png")
except Exception as e: critical(e.args[1])
else: ok()

task("Generating","72x72","image")
try:
    out = im.resize((72, 72),Image.ANTIALIAS)
    out.save("..\\build\\icons\\72x72.png")
except Exception as e: critical(e.args[1])
else: ok()

task("Generating","57x57","image")
try:
    out = im.resize((57, 57),Image.ANTIALIAS)
    out.save("..\\build\\icons\\57x57.png")
except Exception as e: critical(e.args[1])
else: ok()

process("Replacing definitions in build folder...")

task("Replacing in filenames")
try:
    for root, dirs, files in walk("..\\build"):
        for v in files:
            v2 = v
            for defi in definition.keys(): v2 = v2.replace("{" + defi + "}", definition[defi])
            if (v != v2): rename(root + "\\" + v, root + "\\" + v2)
        for v in dirs:
            v2 = v
            for defi in definition.keys(): v2 = v2.replace("{" + defi + "}", definition[defi])
            if (v != v2): rename(root + "\\" + v, root + "\\" + v2)
except Exception as e: critical(e.args[1])
else: ok()

task("Replacing in source files")
try:
    for root, dirs, files in walk("..\\build"):
        files = [ fi for fi in files if fi.endswith((".hx",".xml",".yaml",".txt",".bat",".html",".hxproj")) ]
        for fi in files:
            for line in fileinput.input(root + "\\" + fi, inplace=True):
                for defi in definition.keys():
                    line = line.replace("{" + defi + "}", definition[defi])
                print(line, end='')
except Exception as e: critical(e.args[1])
else: ok()