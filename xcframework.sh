
set -euxo pipefail

rm -rf openvdb.xcframework
rm -rf install-ios install-macos install-ios-sim

sh boost.sh
sh c-blosc.sh
sh openvdb.sh

xcodebuild -create-xcframework \
           -library install-macos/lib/libopenvdb.11.0.0.dylib \
           -headers install-macos/include/openvdb \
           -library install-ios/lib/libopenvdb.11.0.0.dylib \
           -headers install-ios/include/openvdb \
           -output openvdb.xcframework

zip -r openvdb.xcframework.zip openvdb.xcframework
swift package compute-checksum openvdb.xcframework.zip