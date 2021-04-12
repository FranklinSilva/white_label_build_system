#!/bin/bash
PURPLE='\033[0;35m'
GREEN='\033[0;32m'
NC='\033[0m' 

if [ $1 != "rem" -a  $1 != "cm" ]; then
    echo "INVALID VERSION NAME: "$1
    exit 1
fi

declare -a versionArr=("rem" "cm")

appVersion=$1
buildMode=$2
targetPlatform=$3
folderVersion="../versions/${appVersion}"

echo -e "${PURPLE}- - - - - - - - - - - - - - - - - - - - ${NC}"
echo -e "Copying files of version name:  ${GREEN}$appVersion${NC}"
echo -e "Version folder:                 ${GREEN}$folderVersion${NC}"
echo -e "Build Mode:                     ${GREEN}$buildMode${NC}"
echo -e "Target Platform:                ${GREEN}$targetPlatform${NC}"
echo -e "${PURPLE}- - - - - - - - - - - - - - - - - - - - ${NC}"

#replace images
cp -a -f "${folderVersion}/img/." ../src/img
echo "Images have been modified for this version"
echo "..."

#replace color config
cp -f "${folderVersion}/styles/colors.js" ../src/styles
echo "Colors changed"
echo "..."
echo "..."

#replace color config
cp -f "${folderVersion}/styles/metrics.js" ../src/styles
echo "Metrics changed"
echo "..."
echo "..."

#replace translations 
cp -a -f "${folderVersion}/translations/." ../src/translations
echo "Translations added"
echo "..."
echo "..."

if [ $targetPlatform == "android" ]; then
    ./configure_android.sh $appVersion
fi

if [ $targetPlatform == "ios" ]; then
    ./configure_ios.sh $appVersion
fi

##specific feature code
cd features && ./manage_features.sh $appVersion

echo "Configuration done, now build will begin for type: $buildMode"
echo "..."
echo "..."


cd ../

#build app
if [ -z $buildMode ]; then
    echo "Error - Please specify a build mode: develop or production"
    exit 2
fi

if [ $buildMode == "develop" ]; then
    ./develop.sh $targetPlatform
fi

if [ $buildMode == "production" ]; then
    ./release.sh $targetPlatform $appVersion
fi