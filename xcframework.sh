
set -euxo pipefail

rm -rf openvdb.xcframework
rm -rf install-ios install-macos install-ios-sim

sh boost.sh
sh c-blosc.sh
sh tbb.sh
sh openvdb.sh

libtool -static -o libopenvdb-macos.a install-macos/lib/*.a
libtool -static -o libopenvdb-ios.a install-ios/lib/*.a

xcodebuild -create-xcframework \
           -library libopenvdb-macos.a \
           -headers install-macos/include \
           -library libopenvdb-ios.a \
           -headers install-ios/include \
           -output openvdb.xcframework

zip -r openvdb.xcframework.zip openvdb.xcframework
swift package compute-checksum openvdb.xcframework.zip
