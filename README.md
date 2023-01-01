# tradepool_mobile_app

-- In order to build the project, you must run this to ensure the *.g.dart files are genrated
flutter pub run build_runner build --delete-conflicting-outputs

-- Alternatively you can run the following in the project root for continuous rebuild.
flutter pub run build_runner watch

-- To publish the project, do the following
 0.) Make sure that the .env file is updated with the proper API server
 1.)  Open XCode and increment version number 
 2.)  In a terminal, type "flutter build ipa"
 3.)  Open "Transporter" app
 4.)  Open a file explorer
 5.)  Drag the "/users/jasonagee/Development/mobireads_app/build/ios/ipa/*.ipa" bundle into the transporter.
 6.)  Log into https://appstoreconnect.apple.com/
 7.)  Select "My Apps"
 8.)  Select "mobireads"
 9.)  Chose "Testflight" tab
 10.) The new build should display in "processing" mode. Wait for it to become available.
 11.) Accept the midding "Compliance"
 12.) Share the app with "mobireads-dev" external groups.