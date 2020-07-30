#!/usr/bin/env sh

set -e

cur_dir=$PWD

mkdir tmp
cd tmp
npm install @types/p5
mv node_modules/* ..

cd $cur_dir
rm -rf tmp
