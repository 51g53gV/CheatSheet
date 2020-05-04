#!/bin/bash
# Kernel Builder V1.0.0 by Pixailz

sourceFinder (){
  loopSourceFinder=true
  choiceSourceFinder=""

  allPath=`find -type d -name "**DJY-Nethunter-Andrax-Kernel-Source**"`

  sourcePath1=`echo $allPath | cut -d" " -f1`
  sourcePath2=`echo $allPath | cut -d" " -f2`

  while [[ "$loopSourceFinder" == true  ]]; do
    
	  echo -e "$(echo $allPath | wc -w) path found.\nPlease choose one.\n1 : $(echo $sourcePath1)\n2 : $(echo $sourcePath2)"
    read -p "Pix@builder:~#" choiceSource
  done
}
sourceFinder
echo $sourcePath1
echo $sourcePath2

mainMenu (){

  loopMainMenu=true
  choiceMainMenu=""
  
  while [[ "$loopMainMenu" == true ]]; do
    clear
    echo -e "Main Menu\n\t1 : Fajita"
    read -p "Pix@builder:~#" choiceMainMenu
    if [[ "$choiceMainMenu" == "1" ]]; then
      loopMainMenu=false
      fajitaMenu
    else
      echo -e "Wrong choice !"
      sleep 2
    fi
  done
}

fajitaMenu (){
  loopFajitaMenu=true
  choiceFajitaMenu=""
  
  while [[ "$loopFajitaMenu" == true ]]; do
    clear
    echo -e "Fajita Menu\n\t1 : DJY-NetHunter"
    read -p "Pix@builder:~#" choiceFajitaMenu
    if [[ "$choiceFajitaMenu" == "1" ]]; then
      loopFajitaMenu=false
      djyMenu
    else
      echo -e "Wrong choice !"
      sleep 2
    fi
  done
}

djyMenu (){

  loopDJYMenu=true
  pathDJYMenu=""

  while [[ "$loopDJYMenu" == true ]]; do
    clear
    echo -e "DJY-NetHunter\nEnter the absolute path of the DJY kernel source\n\"git clone https://github.com/johanlike/DJY-Nethunter-Andrax-Kernel-Source\""
    echo -e "$(echo $choicDJYMenu)\nSource folder don't exist."
    sleep 2
  done
}

