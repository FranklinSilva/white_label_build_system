PURPLE='\033[0;35m'
GREEN='\033[0;32m'
NC='\033[0m' 

if [ $1 != "android" -a  $1 != "ios" ]; then
    echo "INVALID TARGET PLATFORM: "$1
    exit 1
fi

if [ $1 == "android" ]; then

    cd ../android && ./gradlew assembleRelease && cd ../scripts
    
    number=$(cat ../android/app/build.gradle | grep -m 1 versionCode)
    number2=$(echo $number | cut -d' ' -f 2)
    
    cp -f "../android/app/build/outputs/apk/release/app-release.apk" "../versions/${2}/output/${2}${number2}-release.apk"     

    echo "- - - - - - - - - - - - - - - - - - -"
    echo "APP GENERATED, PLEASE CHECK THE OUTPUT AT ../versions/${2}/output/${2}${number2}-release.apk"
fi

if [ $1 == "ios" ]; then
    cd ../ios && pod install

    echo "- - - - - - - - - - - - - - - - - - -"
    echo -e "${GREEN}APP CONFIGURATED, NOW OPENING THE XCODE...${NC}"
    
    schemeIdentifierVar=$(cat ../versions/${2}/Ios/iosProperties.txt | grep -m 1 scheme=)
    schemeIdentifier=$(echo $schemeIdentifierVar | cut -d'=' -f 2)
     echo -e "${PURPLE}Don't forget to change the scheme to ${GREEN}${schemeIdentifier}${NC} ${PURPLE}before archiving the version${NC}"

     open messagingapp.xcworkspace && cd ../scripts
fi