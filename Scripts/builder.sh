#!/bin/bash
# Kernel Builder V1.0.1 by Pixailz

sourceFinderDJY (){
  
  loopSourceDJY=true
  choiceSourceDJY=""
  sourcePathDJY=""

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
  echo $sourcePathDJY
}

sourceFinderDJY

echo $sourcePathDJY1
echo $sourcePathDJY2