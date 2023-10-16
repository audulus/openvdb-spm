
rm -rf tbb

# see https://github.com/Homebrew/homebrew-core/blob/5401dd66d7c7091ab20dcd46efc9ae64eb2b852e/Formula/t/tbb.rb

wget https://github.com/oneapi-src/oneTBB/archive/refs/tags/v2021.10.0.tar.gz
tar zxf v2021.10.0.tar.gz
mv oneTBB-2021.10.0 tbb 

cd tbb
mkdir build
cd build
cmake ..
make
