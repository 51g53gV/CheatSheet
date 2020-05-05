#!/bin/bash
# Kernel Builder V1.2.0 by Pixailz

sourceFinderDJY (){
  
  loopSourceDJY=true
  choiceSourceDJY=""
  sourcePathDJY=""
  
  echo -e "Searching ..."
  allPathDJY=`find -type d -name "**DJY-Nethunter-Andrax-Kernel-Source**"`

  sourcePathDJY1=`echo $allPathDJY | cut -d" " -f1`
  sourcePathDJY2=`echo $allPathDJY | cut -d" " -f2`

  while [[ "$loopSourceDJY" == true  ]]; do
  
    clear
    
    echo -e "$(echo $allPathDJY | wc -w) path found.\nPlease choose one.\n1 : $(echo $sourcePathDJY1)\n2 : $(echo $sourcePathDJY2)"
    read -p "Pix@builder:~#" choiceSourceDJY
    
    if [[ "$choiceSourceDJY" == "1" ]]; then
      loopSourceDJY=false
      sourcePathDJY=$sourcePathDJY1
      buildDJY

    elif [[ "$choiceSourceDJY" == "2" ]]; then
      loopSourceDJY=false
      sourcePathDJY=$sourcePathDJY2
      buildDJY
      
    else
      echo -e "Wrong choice !"
      sleep 1.5
      
    fi
  done
}

buildDJY (){
  
  echo -e "Preparing download of toolchain."
  cd $sourcePathDJY && cd ..

  echo -e "Downloading DJY toolchain."
  git clone https://github.com/johanlike/DJY-Clang-Binutils-Comprehensive-Toolchains
  
  # save toolchain path for export
  toolchainPathDJY="$(pwd)/DJY-Clang-Binutils-Comprehensive-Toolchains"
  
  echo -e "Moving to source dir"
  cd $sourcePathDJY
  
  echo -e "Exporting some utils var ;)"
  export ARCH=arm64
  export CROSS_COMPILE=$toolchainPathDJY
  export CONFIG_BUILD_ARM64_DT_OVERLAY=y
  
  echo -e "Make (1/5) clean"
  make CC=clang O=./out clean
  make CC=clang O=./out mrproper
  
  echo -e "Make (2/5) config"
  make CC=clang O=./out sdm845-perf_defconfig
  
  echo -e "Make (3/5) prepare"
  make CC=clang O=./out prepare
  make CC=clang O=./out modules_prepare
  
  echo -e "Make (4/5) modules"
  make CC=clang O=./out modules
  
  echo -e "Make (5/5) final"
  make CC=clang O=./out
}

# checking depedencies 
apt-get update && apt-get upgrade
apt-get install build-essential

# Downloading and cd source kernel
git clone https://github.com/johanlike/DJY-Nethunter-Andrax-Kernel-Source && cd DJY-Nethunter-Andrax-Kernel-Source
sourcePath

# Export source path and go back
sourcePath=`pwd` && cd ..

# Downloading and cd toolchain
git clone https://github.com/johanlike/DJY-Clang-Binutils-Comprehensive-Toolchains && cd DJY-Clang-Binutils-Comprehensive-Toolchains

# Export toplchain path and go back to the source 
toolchainPath=`pwd` && cd ../DJY-Nethunter-Andrax-Kernel-Source

# Exporting some utils var
export ARCH=arm64
export CROSS_COMPILE=$toolchainPath
export CONFIG_BUILD_ARM64_DT_OVERLAY=y

# Make (1/5) clean
make CC=clang O=./out clean
make CC=clang O=./out mrproper
  
# Make (2/5) config
make CC=clang O=./out sdm845-perf_defconfig
 
# Make (3/5) prepare
 
make CC=clang O=./out prepare
make CC=clang O=./out modules_prepare
  
# Make (4/5) modules
make CC=clang O=./out modules
  
# Make (5/5) final
make CC=clang O=./out
