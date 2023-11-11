
set -euxo pipefail

rm -rf openvdb.xcframework
rm -rf install-ios install-macos install-ios-sim

sh boost.sh
sh c-blosc.sh
sh tbb.sh
sh openvdb.sh

# tbb can't be built as a static library, so we'll use 
# a separate package
rm -rf install-macos/include/tbb
rm -rf install-ios/include/tbb

libtool -static -o libopenvdb-macos.a install-macos/lib/libopenvdb.a install-macos/lib/libboost_iostreams.a install-macos/lib/libboost_regex.a install-macos/lib/libblosc.a
libtool -static -o libopenvdb-ios.a install-ios/lib/libopenvdb.a install-ios/lib/libboost_iostreams.a install-ios/lib/libboost_regex.a install-ios/lib/libblosc.a

xcodebuild -create-xcframework \
           -library libopenvdb-macos.a \
           -headers install-macos/include \
           -library libopenvdb-ios.a \
           -headers install-ios/include \
           -output openvdb.xcframework

zip -r openvdb.xcframework.zip openvdb.xcframework
swift package compute-checksum openvdb.xcframework.zip
