#!/bin/bash

runUatPath="/home/ubuntu/UE/Linux_Unreal_Engine_5.4.1/Engine/Build/BatchFiles/RunUAT.sh"
buildConfig=$1 #"Development"
platform=$2 #"linux"
archive=$3 #"true"
app_version=${4:-"0.1.2400.1"}
archivePath=$5
maps=$6 #"false"

# Make sure there is only one uproject file in the project.
uprojectCount=$(find .. -type f -name "*.uproject" | wc -l) 
if [ "$uprojectCount" != 1 ]; then
	echo "Error: $uprojectCount uproejct files exist.Please make sure there is only one uproject file in the project!"
	exit 1
fi

# Search for *.uproject file in the upper folder and change the relative path into absolute
uprojectPath=$(find .. -type f -name "*.uproject" | xargs -0 -I {} readlink -f {})

archiveArg=$( [ "$archive" = 'true' ] && echo "-archive -archivedirectory=$archivePath" )
mapsArg=$( [ "$maps" = 'true' ] && echo "" || echo "-map=$maps" )

command="$runUatPath BuildCookRun -project=$uprojectPath -clientconfig=$buildConfig -platform=$platform $mapsArg -clean -cook -stage -pak -package $archiveArg -encryptinifiles -noP4 -build -unattended -utf8output"

echo -e "buildcookrun commandline is:\n"$command
sh -c "$command"

# Rename the archive to add the version number
for dir in $archivePath/*
do
	new_name=$dir"_"$app_version
	mv "$dir" "$new_name/"
done

