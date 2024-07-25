#!/bin/bash

runUatPath="/home/ubuntu/UE/Linux_Unreal_Engine_5.4.1/Engine/Build/BatchFiles/RunUAT.sh"
uprojectPath="/home/ubuntu/actions-runner/_work/ActionsTest/ActionsTest/ActionsTest.uproject"
buildConfig="Development"
platform="linux"
archive="true"
archivePath="/home/ubuntu/ActionsOutput/"
maps="false"

# Make sure there is only one uproject file in the project.
uprojectCount=$(find .. -type f -name "*.uproject" | wc -l) 
if [ "$uprojectCount" != 1 ]; then
	echo "Error: $uprojectCount uproejct files exist.Please make sure there is only one uproject file in the project!"
	exit 1
fi

# Search for *.uproject file in the upper folder and change the relative path into absolute
uprojectPath=$(find .. -type f -name "*.uproject" | xargs -0 -I {} readlink -f {})

archiveArg=$( [ "$archive" = 'true' ] && echo "-archive -archivedirectory=$archivePath" )
encryptIniArg=$( [ "$encryptIni" = 'true' ] && echo "-encryptinifiles" )
patchArg=$( [ "$patch" != 'false' ] && echo "-generatepatch -basedonreleaseversion=$patch" )
mapsArg=$( [ "$maps" = 'true' ] && echo "" || echo "-map=$maps" )

command="$runUatPath BuildCookRun -project=$uprojectPath -clientconfig=$buildConfig -platform=$platform $mapsArg -clean -cook -stage -pak -package $archiveArg -encryptinifiles -noP4 -build -unattended -utf8output"

echo -e "buildcookrun commandline is:\n"$command
#sh -c "$command"
