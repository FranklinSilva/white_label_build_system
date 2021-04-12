PURPLE='\033[0;35m'
GREEN='\033[0;32m'
NC='\033[0m' 


appVersion=$1

#execute yarn
echo "Executing third-party intallation"
echo "..."
echo "..."
echo "..."
yarn

#replace res files for ios
cp -f -r "../versions/${appVersion}/Ios/Images.xcassets/." ../ios/messagingapp/Images.xcassets/.
echo "Icons configurated"
echo "..."
echo "..."
echo "..."

#replace res files for ios
cp -f "../versions/${appVersion}/Ios/LaunchScreen.xib" ../ios/messagingapp/Base.lproj/LaunchScreen.xib
echo "Splash Art configurated"
echo "..."
echo "..."
echo "..."


#Variables for info.plist
CFBundleDisplayNameVar=$(cat ../versions/${appVersion}/Ios/iosProperties.txt | grep -m 1 CFBundleDisplayName)
CFBundleDisplayName=$(echo $CFBundleDisplayNameVar | cut -d'=' -f 2)

CFBundleShortVersionStringVar=$(cat ../versions/${appVersion}/Ios/iosProperties.txt | grep -m 1 CFBundleShortVersionString)
CFBundleShortVersionString=$(echo $CFBundleShortVersionStringVar | cut -d'=' -f 2)

CFBundleVersionVar=$(cat ../versions/${appVersion}/Ios/iosProperties.txt | grep -m 1 CFBundleVersion)
CFBundleVersion=$(echo $CFBundleVersionVar | cut -d'=' -f 2)

#Variables for project.pbxproj
productBundleIdentifierVar=$(cat ../versions/${appVersion}/Ios/iosProperties.txt | grep -m 1 PRODUCT_BUNDLE_IDENTIFIER=)
productBundleIdentifier=$(echo $productBundleIdentifierVar | cut -d'=' -f 2)

#productNameIdentifierVar=$(cat ../versions/${appVersion}/Ios/iosProperties.txt | grep -m 1 PRODUCT_NAME=)
#productNameIdentifier=$(echo $productNameIdentifierVar | cut -d'=' -f 2)

echo -e "${PURPLE}These are the variables to be configured for the IOS Project${NC}"
echo -e "Changes in file: ${GREEN}ios/info.plist${NC}"

echo -e "App's Display Name -> ${GREEN}${CFBundleDisplayName}${NC}"
CFBundleDisplayNameFileLine=$(cat ../ios/messagingapp/Info.plist | grep -A 1 CFBundleDisplayName | tail -n 1)
CFBundleDisplayNameFileLineCutted=$(echo $CFBundleDisplayNameFileLine | cut -d'/' -f 1) #Beucase the code obtained has "/" which is prohibited without scaping, it was necessary to remove the slash and add it back when changing the Info.plist  
sed -i -e "s/${CFBundleDisplayNameFileLineCutted}\/string>/<string>${CFBundleDisplayName}<\/string>/g" ../ios/messagingapp/Info.plist

echo -e "App's Version -> ${GREEN}${CFBundleShortVersionString}${NC}"
CFBundleShortVersionStringLine=$(cat ../ios/messagingapp/Info.plist | grep -A 1 CFBundleShortVersionString | tail -n 1)
CFBundleShortVersionStringCutted=$(echo $CFBundleShortVersionStringLine | cut -d'/' -f 1) #Beucase the code obtained has "/" which is prohibited without scaping, it was necessary to remove the slash and add it back when changing the Info.plist  
sed -i -e "s/${CFBundleShortVersionStringCutted}\/string>/<string>${CFBundleShortVersionString}<\/string>/g" ../ios/messagingapp/Info.plist

echo -e "App's Build Number -> ${GREEN}${CFBundleVersion}${NC}"
CFBundleVersionLine=$(cat ../ios/messagingapp/Info.plist | grep -A 1 CFBundleVersion | tail -n 1)
CFBundleVersionCutted=$(echo $CFBundleVersionLine | cut -d'/' -f 1) #Beucase the code obtained has "/" which is prohibited without scaping, it was necessary to remove the slash and add it back when changing the Info.plist  
sed -i -e "s/${CFBundleVersionCutted}\/string>/<string>${CFBundleVersion}<\/string>/g" ../ios/messagingapp/Info.plist

echo -e "\n"
echo -e "Changes in file: ${GREEN}ios/messagingapp.xcodeproj/project.pbxproj${NC}"

echo -e "App's Bundler Identifier -> ${GREEN}${productBundleIdentifier}${NC}"
productBundleIdentifierFileLine=$(cat ../ios/messagingapp.xcodeproj/project.pbxproj | grep com.brisausa)
productBundleIdentifierCuttedA=$(echo $productBundleIdentifierFileLine | cut -d';' -f 1)
sed -i -e "s/${productBundleIdentifierCuttedA}/PRODUCT_BUNDLE_IDENTIFIER = ${productBundleIdentifier}/g" ../ios/messagingapp.xcodeproj/project.pbxproj

#echo -e "App's Product Name -> ${GREEN}${productNameIdentifier}${NC}"
#productNameIdentifierFileLine=$(cat ../ios/messagingapp.xcodeproj/project.pbxproj | grep PRODUCT_NAME)
#productNameIdentifierCuttedA=$(echo $productNameIdentifierFileLine | cut -d';' -f 1)
#sed -i -e "s/${productNameIdentifierCuttedA}/PRODUCT_NAME = ${productNameIdentifier}/g" ../ios/messagingapp.xcodeproj/project.pbxproj


#xcodebuild -workspace messagingapp.xcworkspace  -configuration release -scheme messagingapp

#xcodebuild -workspace messagingapp.xcworkspace -scheme clientmessaging archive