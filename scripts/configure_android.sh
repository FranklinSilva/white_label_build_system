PURPLE='\033[0;35m'
GREEN='\033[0;32m'
NC='\033[0m' 

appVersion=$1

#replace res files for android
cp -f -r "../versions/${appVersion}/Android/res/." ../android/app/src/main/res
echo "Icons and splash arts configurated"
echo "..."
echo "..."
echo "..."

#Variables for gradle.properties
keystoreFileVar=$(cat ../versions/${appVersion}/Android/androidProperties.txt | grep -m 1 keystoreFile)
keystoreFile=$(echo $keystoreFileVar | cut -d'=' -f 2)

keyAliasVar=$(cat ../versions/${appVersion}/Android/androidProperties.txt | grep -m 1 keyAlias)
keyAlias=$(echo $keyAliasVar | cut -d'=' -f 2)

keystorePasswordVar=$(cat ../versions/${appVersion}/Android/androidProperties.txt | grep -m 1 keystorePassword)
keystorePassword=$(echo $keystorePasswordVar | cut -d'=' -f 2)

keyPasswordVar=$(cat ../versions/${appVersion}/Android/androidProperties.txt | grep -m 1 keyPassword)
keyPassword=$(echo $keyPasswordVar | cut -d'=' -f 2)

#Variables for app/build.gradle
applicationIdVar=$(cat ../versions/${appVersion}/Android/androidProperties.txt | grep -m 1 applicationId)
applicationId=$(echo $applicationIdVar | cut -d'=' -f 2)

versionCodeVar=$(cat ../versions/${appVersion}/Android/androidProperties.txt | grep -m 1 versionCode)
versionCode=$(echo $versionCodeVar | cut -d'=' -f 2)

versionNameVar=$(cat ../versions/${appVersion}/Android/androidProperties.txt | grep -m 1 versionName)
versionName=$(echo $versionNameVar | cut -d'=' -f 2)

echo -e "${PURPLE}These are the variables to be configured for the Android Project${NC}"
echo -e "Changes in file: ${GREEN}android/gradle.properties${NC}"

echo -e "keystoreFile -> ${GREEN}${keystoreFile}${NC}"
keystoreFileLine=$(cat ../android/gradle.properties | grep -m 1 MYAPP_RELEASE_STORE_FILE)
sed -i -e "s/${keystoreFileLine}/MYAPP_RELEASE_STORE_FILE=${keystoreFile}/g" ../android/gradle.properties
cp -a -f "../versions/${appVersion}/Android/${keystoreFile}" ../android/app

echo -e "keyAlias -> ${GREEN}${keyAlias}${NC}"
keyAliasLine=$(cat ../android/gradle.properties | grep -m 1 MYAPP_RELEASE_KEY_ALIAS)
sed -i -e "s/${keyAliasLine}/MYAPP_RELEASE_KEY_ALIAS=${keyAlias}/g" ../android/gradle.properties

echo -e "keystorePassword ${GREEN}${keystorePassword}${NC}"
keystorePasswordLine=$(cat ../android/gradle.properties | grep -m 1 MYAPP_RELEASE_STORE_PASSWORD)
sed -i -e "s/${keystorePasswordLine}/MYAPP_RELEASE_STORE_PASSWORD=${keystorePassword}/g" ../android/gradle.properties

echo -e "keyPassword ${GREEN}${keyPassword}${NC}"
keyPasswordLine=$(cat ../android/gradle.properties | grep -m 1 MYAPP_RELEASE_KEY_PASSWORD)
sed -i -e "s/${keyPasswordLine}/MYAPP_RELEASE_KEY_PASSWORD=${keyPassword}/g" ../android/gradle.properties

echo -e "\n"
echo -e "Changes in file: ${GREEN}android/app/build.gradle${NC}"

echo -e "applicationId ${GREEN}${applicationId}${NC}"
applicationIdLine=$(cat ../android/app/build.gradle | grep -m 1 applicationId)
sed -i -e "s/${applicationIdLine}/      applicationId \"${applicationId}\"/g" ../android/app/build.gradle

#applicationIdLineManifest=$(cat ../android/app/src/main/AndroidManifest.xml | grep -m 1 package=\")
#echo -e "applicationIdLineManifest ${GREEN}${applicationIdLineManifest}${NC}"
#sed -i -e "s/${applicationIdLineManifest}/  package=\"${applicationId}\">/g" ../android/app/src/main/AndroidManifest.xml

echo -e "versionCode ${GREEN}${versionCode}${NC}"
versionCodeLine=$(cat ../android/app/build.gradle | grep -m 1 versionCode)
sed -i -e "s/${versionCodeLine}/      versionCode ${versionCode}/g" ../android/app/build.gradle

echo -e "versionName ${GREEN}${versionName}${NC}"
versionNameLine=$(cat ../android/app/build.gradle | grep -m 1 versionName)
sed -i -e "s/${versionNameLine}/      versionName \"${versionName}\"/g" ../android/app/build.gradle