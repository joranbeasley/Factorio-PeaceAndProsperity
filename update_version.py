import json
import os
import shutil
import tempfile
from deploy_utils import find_package_folder,zipdir

tag = os.popen("git describe --tags").read().strip()
package_directory = find_package_folder()
info_file = os.path.join(package_directory,"info.json")
data = json.load(open(info_file))
data["version"] = tag
json.dump(data,open(info_file,"wb"))

package_name = os.path.basename(package_directory)+"_"+tag
tmp_dir = tempfile.mkdtemp()
dst_dir = os.path.join(tmp_dir,package_name)
shutil.copytree(package_directory,dst_dir)
zipdir(dst_dir,open(package_name+".zip","wb"))
shutil.rmtree(tmp_dir)
print package_name+".zip"