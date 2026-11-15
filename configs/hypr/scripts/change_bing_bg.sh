#!/bin/bash

number=$(($RANDOM % 12 + 1))
echo $number
path="/home/$USER/Bing/$number.jpg"
swww img $path -t wave --transition-wave 50,50
