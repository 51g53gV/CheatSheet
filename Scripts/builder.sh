#!/bin/bash
# Kernel Builder V1.3.0 by Pixailz

buildDownloadDJY (){

  echo -e "\nChecking depedencies\n" 
  apt-get update && apt-get upgrade
  apt-get install build-essential
  
  if [[ ! -d DJY-Nethunter-Andrax-Kernel-Source ]]; then
    echo -e "\nDownloading source dir\n"
    git clone https://github.com/Pixailz/DJY-Nethunter-Andrax-Kernel-Source
  else
    echo -e "\nSource dir already exist\n"
  fi
  
  if [[ ! -d DJY-Clang-Binutils-Comprehensive-Toolchains ]]; then
    echo -e "\nDownloading toolchain\n"
    git clone https://github.com/johanlike/DJY-Clang-Binutils-Comprehensive-Toolchains
  else
    echo -e "\nToolchain dir already exist\n" 
  fi

  echo -e "\nExporting some utils var\n"
  currentPath=$(pwd)
  sourcePath=$(echo $currentPath)/DJY-Nethunter-Andrax-Kernel-Source
  toolchainPath=$(echo $currentPath)/DJY-Clang-Binutils-Comprehensive-Toolchains/bin/aarch64-linux-gnu-
  
  echo -e "Current Path :\t\t$(echo $currentPath)"
  echo -e "Source Path :\t\t$(echo $sourcePath)"
  echo -e "ToolchainPath :\t\t$(echo $toolchainPath)"
  read -p "press q to quit" -n 1 choiceConfirm
  
  case $choiceConfirm in 
    [qQnN]*) exit 1;;
  esac

  export ARCH=arm64
  export CROSS_COMPILE=$(echo $toolchainPath)
  export CONFIG_BUILD_ARM64_DT_OVERLAY=y
  
  echo -e "\nMake (1/5) clean\n"
  make CC=clang O=./out clean
  make CC=clang O=./out mrproper
    
  echo -e "\nMake (2/5) config\n"
  make CC=clang O=./out sdm845-perf_defconfig
   
  echo -e "\nMake (3/5) prepare\n"
  
  make CC=clang O=./out prepare
  make CC=clang O=./out modules_prepare
    
  echo "\nMake (4/5) modules\n"
  make CC=clang O=./out modules
    
  echo -e "\nMake (5/5) final\n"
  make CC=clang O=./out
}

mainMenu (){
  
  loopMainMenu=true
  choiceMainMenu=""
  
  while [[ "$loopMainMenu" == true ]]; do
    clear
    
    echo "Main menu"
    echo "  1 : Download and build DJY-Kernel"
    read -p "Pix@builder:~# " choiceMainMenu
    
    if [[ "$choiceMainMenu" == "1" ]]; then
      loopMainMenu=false
      buildDownloadDJY
      
    else
      echo "Wrong choice !"
      sleep 1.5
      
    fi
  done
}

mainMenu
