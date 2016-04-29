import os
from os.path import isdir,join as path_join,exists

import zipfile

def zipdir(path, ziph):
    # ziph is zipfile handle
    cwd = os.getcwd()
    os.chdir(os.path.join(path,".."))
    for root, dirs, files in os.walk(os.path.split(path)[-1]):
        for file in files:
            fpath = os.path.join(root, file)
            ziph.write(fpath)
    os.chdir(cwd)

def find_package_folder():
    for fname in os.listdir("."):
        if isdir(fname) and exists(path_join(fname,"info.json")) and os.path.exists(path_join(fname,"data.lua")):
                return fname

