
set -euxo pipefail

rm -rf openvdb.xcframework
rm -rf install-ios install-macos install-ios-sim

sh boost.sh
sh c-blosc.sh
sh tbb.sh
sh openvdb.sh

xcodebuild -create-xcframework \
           -library install-macos/lib/libopenvdb.a \
           -headers install-macos/include \
           -library install-ios/lib/libopenvdb.a \
           -headers install-ios/include \
           -output openvdb.xcframework

zip -r openvdb.xcframework.zip openvdb.xcframework
swift package compute-checksum openvdb.xcframework.zip