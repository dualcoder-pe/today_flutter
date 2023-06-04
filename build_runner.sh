cd entity
flutter pub get

cd ../common
flutter pub get

cd ../domain
flutter pub get

cd ../data
flutter pub get
flutter pub run build_runner build -d

cd ../service
flutter pub get

cd ../presentation
sh build_runner.sh

cd ..
flutter pub get

