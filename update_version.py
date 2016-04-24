import json
import os
import shutil
import tempfile
import zipfile

from deploy_utils import find_package_folder,zipdir,get_version_tag

tag = get_version_tag()
package_directory = find_package_folder()
info_file = os.path.join(package_directory,"info.json")
data = json.load(open(info_file))
data["version"] = tag
json.dump(data,open(info_file,"wb"))

package_name = os.path.basename(package_directory)+"_"+tag
tmp_dir = tempfile.mkdtemp()
dst_dir = os.path.join(tmp_dir,package_name)
shutil.copytree(package_directory,dst_dir)
zipdir(dst_dir,zipfile.ZipFile(package_name+".zip","w"))
shutil.rmtree(tmp_dir)
print package_name+".zip"