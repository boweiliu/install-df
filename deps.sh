#!/bin/bash

sudo apt-get update
sudo apt-get install -y python python-dev python-pip
pip install -U pip
pip install awscli  || sudo pip install awscli

aws configure
aws s3 ls boweiliu-dwarf-fortress

sudo apt-get install -y libsdl1.2debian libsdl-image1.2 libSDL-ttf2.0-0 libgtk2.0-0 libglu1-mesa


wget http://www.bay12games.com/dwarves/df_43_05_linux.tar.bz2
tar xjvf df_*.bz2
cd df_linux

# use PRINT_MODE:TEXT and set window size to match current terminal size (`tput cols` by `tput lines`)
cat data/init/init.txt  \
  | sed 's/\[WINDOWEDX:[^]]*\]/[WINDOWEDX:'`tput cols`']/g' \
  | sed 's/\[WINDOWEDY:[^]]*\]/[WINDOWEDX:'`tput lines`']/g' \
  | sed 's/\[PRINT_MODE:[^]]*\]/[PRINT_MODE:TEXT]/g' \
  | sed 's/\[SOUND:[^]]*\]/[SOUND:NO]/g' \
  | sed 's/\[INTRO:[^]]*\]/[INTRO:NO]/g' \
  | sed 's/\[FPS:[^]]*\]/[FPS:YES]/g' \
  | sed 's/\[FULLSCREENX:[^]]*\]/[FULLSCREENX:'`tput cols`']/g' \
  | sed 's/\[FULLSCREENY:[^]]*\]/[FULLSCREENY:'`tput lines`']/g' \
  > /tmp/init.txt && mv /tmp/init.txt data/init/init.txt



# cd df_linux/data && aws s3 sync . s3://boweiliu-dwarf-fortress/data/
