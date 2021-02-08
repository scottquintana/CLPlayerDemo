![MacDown logo](https://github.com/scottquintana/CLPlayerDemo/blob/main/ConchaLabsPlayerDemo/Images/clheader.png)
## CLPlayerDemo
An app to listen to a Casio drum loop on repeat for as long as you'd like.
##
1. Clone repo.
2. Fill the `CLIENT_ID` and `REVERSED_CLIENT_ID` fields in the `GoogleService-Info.plist` file with the appropriate info. If the ID's were not provided to you already, please contact dev@scottquintana.com.
3. To enable reCAPTCHA verification, add your reversed client ID as a URL scheme (for example, to enable Google Sign-in).
![Reverse_URL](https://developers.google.com/identity/sign-in/ios/images/xcode_infotab_url_type_values.png)

2. Dependencies are managed with CocoaPods. The Pods folder is checked into the repo so no `pod install` is necessary.
3. Run and enjoy!
