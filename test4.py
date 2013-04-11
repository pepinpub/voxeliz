
import os
import sys
import math
import time
import urllib
import maya.standalone
import maya.cmds as cmds

# time.sleep(10)
#objUrl = "https://s3-eu-west-1.amazonaws.com/vox3/images/avatars/26_original_pitcher.obj"
objUrl = sys.argv[1]
fileToOpen= "tmp.obj"

#On download le fichier en local
urllib.urlretrieve (objUrl,fileToOpen)
# urllib.urlretrieve ("http://vox3.s3.amazonaws.com/3dmodels/users/2/original_pitcher.obj","tmp.obj")
# Start Maya in batch mode
maya.standalone.initialize(name='python')
os.environ['MAYA_LOCATION']="/Applications/Autodesk/maya2013/Maya.app/Contents"

# Open the file with the file command
cmds.file(fileToOpen, force=True, open=True)

#On manipule le fichier car problem area=0 obj issue?
#L ecriture des fichiers ne semble pas fonctionner avec la version etudiant..?
	# cmds.file(rename='tmp.mb' )
	# removeme = cmds.file('tmp.mb', force=True, open=True)

	#cmds.file("/tmp/tmp.obj", force=True, open=True)
name=cmds.ls(g=1)
# print cmds.polyEvaluate(name, wa=1)
bbox = cmds.polyEvaluate(name, boundingBox=1);
bbX = math.fabs(bbox[0][0]-bbox[0][1]);
bbY = math.fabs(bbox[1][0]-bbox[1][1]);
bbZ = math.fabs(bbox[2][0]-bbox[2][1]);

print bbX, bbY, bbZ;



"""
print name
area = cmds.polyEvaluate(name, area=1)
print cmds.polyEvaluate(name, f=1)
print cmds.polyEvaluate(name, t=1)
print cmds.polyEvaluate(name, b=1)
"""


#os.remove('/tmp/tmp.obj')
