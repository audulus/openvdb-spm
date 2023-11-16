
set -euxo pipefail

# See https://formulae.brew.sh/formula/boost

rm -rf boost
rm -f boost_1_83_0.tar.bz2

# git clone https://github.com/boostorg/boost.git
# git submodule update --recursive --init

wget https://boostorg.jfrog.io/artifactory/main/release/1.83.0/source/boost_1_83_0.tar.bz2
tar zxf boost_1_83_0.tar.bz2
mv boost_1_83_0 boost

export root=`pwd`
cd boost

B2_ARGS="-a -j8 --with-iostreams --with-regex"

./bootstrap.sh --prefix=$root/install-macos
./b2 $B2_ARGS --prefix=$root/install-macos link=static install
./b2 clean

# Build arm64
./bootstrap.sh --prefix=$root/install-ios --with-libraries=iostreams,regex

IOS_SDK_PATH=$(xcrun --sdk iphoneos --show-sdk-path)
cat << EOF >> project-config.jam
# IOS ARM64
using clang : iphoneos
: xcrun clang++ -arch arm64 -stdlib=libc++ -std=c++20 -miphoneos-version-min=12.0 -fvisibility-inlines-hidden -isysroot $IOS_SDK_PATH
;
EOF

./b2 $B2_ARGS --prefix=$root/install-ios toolset=clang-iphoneos binary-format=mach-o abi=aapcs install
./b2 clean

# Build for simulator
./bootstrap.sh --prefix=$root/install-ios-sim

IOSSIM_SDK_PATH=$(xcrun --sdk iphonesimulator --show-sdk-path)
cat << EOF >> project-config.jam
# IOS simulator arm64 
using clang : iphonesimulator
: xcrun clang++ -arch arm64 -stdlib=libc++ -std=c++20 -miphoneos-version-min=12.0 -fvisibility-inlines-hidden -isysroot $IOSSIM_SDK_PATH
;
EOF

./b2 $B2_ARGS --prefix=$root/install-ios-sim toolset=clang-iphonesimulator binary-format=mach-o abi=sysv link=static install
./b2 clean

cd ..
rm -rf boost boost_1_83_0.tar.bz2
