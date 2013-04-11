
import os
import sys
import urllib
import maya.standalone
import maya.cmds as cmds


#objUrl = "https://s3-eu-west-1.amazonaws.com/vox3/images/avatars/26_original_pitcher.obj"
objUrl = sys.argv[1]
fileToOpen= "tmp.obj"

#On download le fichier en local
urllib.urlretrieve (objUrl,fileToOpen)

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
print cmds.polyEvaluate(name, wa=1)


"""
print name
area = cmds.polyEvaluate(name, area=1)
print cmds.polyEvaluate(name, f=1)
print cmds.polyEvaluate(name, t=1)
print cmds.polyEvaluate(name, b=1)
"""


#os.remove('/tmp/tmp.obj')
