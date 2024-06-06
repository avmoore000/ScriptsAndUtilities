# Written by Andrew Moore
# moorehxg@amazon.com
# Last Modified 1-22-2021 at 2:55PM

# This is a script to generate duplicates of files on a hard drive for testing purposes.

#!/bin/bash

# Get the file name
echo "Enter the path to the drive with no ending / (i.e.: /media/usb1):  "
read drivePath
echo "Enter name of file to duplicate:  "
read fileName
echo "Enter the size of space to fill in GB (0 to fill entire drive):  " 
read driveSize

driveFill=$driveSize

if [ $driveSize -eq 0 ] # Fill the whole drive
then
    let driveFill=$(df -P $drivePath | tail -1 | awk '{print $4}')
fi

echo
echo
echo
echo "Starting script with the following parameters:"
echo "Drive Path:  $drivePath"
echo "File to Duplicate:  $fileName"
echo "Space to fill:  $driveFill"

sleep 1

# Find out the size of the file in bytes
size=$(stat -c '%s' -- $fileName)

let driveFill="$driveFill * 1024 * 1024 * 1024" #Calculate the size of space to fill in bytes

let loop="driveFill / $size" # Loop the correct number of times to fill the space

for (( i=0; i<=$loop; i++ ))  # Loop over and fill the drive
do
    cp $drivePath/$fileName $drivePath/$i.mp4
done
