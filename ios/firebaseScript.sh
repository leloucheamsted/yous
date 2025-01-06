if [ "$CONFIGURATION" == "Debug-youscribeDev" ] || [ "$CONFIGURATION" == "Release-youscribeDev" ]; then
  cp Runner/youscribeDev/GoogleService-Info.plist Runner/GoogleService-Info.plist
elif [ "$CONFIGURATION" == "Debug-maktabatiDev" ] || [ "$CONFIGURATION" == "Release-maktabatiDev" ]; then
  cp Runner/maktabatiDev/GoogleService-Info.plist Runner/GoogleService-Info.plist
fi

