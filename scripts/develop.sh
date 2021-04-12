if [ $1 != "android" -a  $1 != "ios" ]; then
    echo "INVALID TARGET PLATFORM: "$1
    exit 1
fi

if [ $1 == "android" ]; then
    cd ../ && react-native run-android && cd scripts
fi

if [ $1 == "ios" ]; then
    cd ../ios && pod install && cd ../ && react-native run-ios && cd scripts
fi
