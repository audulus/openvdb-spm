
rm -rf boost

# git clone https://github.com/boostorg/boost.git
# git submodule update --recursive --init

wget https://boostorg.jfrog.io/artifactory/main/release/1.83.0/source/boost_1_83_0.tar.bz2
tar zxf boost_1_83_0.tar.bz2
mv boost_1_83_0 boost

cd boost
./bootstrap.sh

cat << EOF >> project-config.jam
# IOS ARM64
using clang : iphoneos
: xcrun clang -arch arm64 -stdlib=libc++ -std=c++20 -miphoneos-version-min=12.0 -fvisibility-inlines-hidden -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk
;

# IOS simulator arm64 
using clang : iphonesimulator
: xcrun clang -arch arm64 -stdlib=libc++ -std=c++20 -miphoneos-version-min=12.0 -fvisibility-inlines-hidden -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk
;
EOF

for lib in libboost_iostreams.a
do

    # Build arm64
    ./b2 -a -j4 toolset=clang-iphoneos binary-format=mach-o abi=aapcs link=static $lib 
    # mv $dir/$lib $dir/arm64_$lib

    # Build for simulator
    #./b2 -a -j4 toolset=clang-iphonesimulator binary-format=mach-o abi=sysv link=static $lib 
    #mv $dir/$lib $dir/arm64_sim_$lib

done
