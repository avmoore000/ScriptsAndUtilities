#!/bin/bash

# Find the number of ports on the daughter card(s).
numPorts=`ifconfig -a | grep eth | wc -l`


# Create a container for all of the port number (i.e. eth1 ... eth5)
STR=`ifconfig | grep eth | sort -k5 | awk '/eth/ {print $1}'`

# Create an array from the STR string so we can step through the ports.
A=($STR)


# Loop through the ports and give them an ip address in the 10.0.0.x
# range, and bring the interface up.

COUNTER=0

# Start the range of IP's at 10.0.0.1
currentIP=1

while [ $COUNTER -lt $numPorts ]; do
	
	echo The counter is $COUNTER
	echo The port number is ${A[$COUNTER]}

	# Use ifconfig to configure the ports on the card and enable them.
	# The port is selected from the array A, using the current value
	# of COUNTER.  The IP range is in the form 10.0.0.X, with X corresponding
	# to the value of CurrentIP.
	
	ifconfig ${A[$COUNTER]} 10.0.0.${currentIP} up

	# Use ethtool to upload the firmware update to out port.  The firmware
	# version to be used is specified by the user as a command line argument
	# when starting the script.  The if statement checks to make sure the 
	# port is not already at the correct firmware level.

	tempString=`ethtool -i ${A[$COUNTER]} | awk '/firmware-version/ {print $3}'`
	strLength=${#tempString}

	if [ $strLength -eq 0 ]; then
	
		echo Updating firmware on ${A[$COUNTER]}

		ethtool -f ${A[$COUNTER]} $1
		
		echo Update Complete.

	fi
	
	let COUNTER=COUNTER+1
	let CurrentIP=CurrentIP+1
done

# Display the current firmware version for all of the ports.  Allows the user
# to verify that the ports have been updated to the correct version.  The results
# will be stored in firmwareVersions, then echoed to the user.

COUNTER=0

while [ $COUNTER -lt $numPorts ]; do

	ethtool -i $A[$COUNTER] 
	
	let COUNTER=COUNTER+1
#done


	



