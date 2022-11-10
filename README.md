# tradepool_mobile_app

-- In order to build the project, you must run this to ensure the *.g.dart files are genrated
flutter pub run build_runner build --delete-conflicting-outputs

-- Alternatively you can run the following in the project root for continuous rebuild.
flutter pub run build_runner watch

-- To publish the project, do the following
 1.) Open XCode and increment version number 
 2.) In a terminal, type "flutter build ipa"
 3.) Open "Transporter" app
 4.) Open a file explorer
 5.) Drag the "build/ios/ipa/*.ipa" bundle into the transporter.
 6.) 