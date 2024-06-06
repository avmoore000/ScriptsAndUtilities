#!/bin/bash

# Create a menu for users.
# 1.  Disk Stress
# 2.  Rolling reboot
# 3.  Disk Stress and Rolling reboot

# Find out system user is running.

# Rolling reboot

KERNEL=`uname -s`
touch /RollingRebootLog

echo 'System rebooted at the following times:  ' > /RollingRebootLog

if [$KERNEL -eq 'Linux']; then 
	
	echo '*/5 * * * * echo date >> /RollingRebootLog init 6' > /var/spool/cron/root
	echo '*/5 * * * * init 6' >> /var/spool/cron/root

fi

if [$KERNEL -eq 'AIX']; then

	echo date > /RollingRebootLog
	echo '0,15,30,45 * * * * reboot' > /var/spool/cron/root

fi



