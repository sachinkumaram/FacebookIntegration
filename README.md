## Implement Facebook login screen 
 - ** any user can login with his credentials.
 - ** Fetch 5 random user's friends and show their profile images in one screen.
 - ** Added more 5 "fake" friends.
 - ** If user selected all real friends it will show success alert message otherwise it will show error message.
  and Change the images to other random friends.


## Getting Started

- **[CocoaPods](https://cocoapods.org)**
    - Make sure you are running the latest version of CocoaPods by running:
      ```bash
      gem install cocoapods
      # (or if the above fails)
      sudo gem install cocoapods
      ```
      _We support any version of CocoaPods 1.0.1 or later._

    - Update your local specs repo by running:
      ```bash
      pod repo update
      ```
      _This step is optional, if you updated the specs repo recently._

    - Add the following lines to your Podfile:
    
      ```ruby
      pod 'FacebookCore'
      pod 'FacebookLogin'
      pod 'FacebookShare'
      ```
    - Run `pod install`
    - You are all set!

 You may also exclude any of these dependencies, if you do not need the features of those parts of the SDK.


    -  Register the iOS app on developer Facebook account and make entry of FB ID in URL Schemes info.plist file.



