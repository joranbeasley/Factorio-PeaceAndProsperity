import os
from os.path import isdir,join as path_join,exists

import zipfile

def zipdir(path, ziph):
    # ziph is zipfile handle
    for root, dirs, files in os.walk(path):
        for file in files:
            ziph.write(os.path.join(root, file))

def find_package_folder():
    for fname in os.listdir("."):
        if isdir(fname) and exists(path_join(fname,"info.json")) and os.path.exists(path_join(fname,"data.lua")):
                return fname

