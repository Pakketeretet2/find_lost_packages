#!/bin/zsh
#
# Tries to determine all installed packages from all files in /usr, /bin and /opt.
# Requires pkgfile. Requires pkgfile and xargs
#

if [ $( id -u ) -gt 0 ]; then
	echo "This script needs to be run with root privileges!" > /dev/stderr
	exit -1
fi


# If you think you have packages that installed somewhere else (and only there)
# you should add those dirs to the DIRS list.
DIRS=(/usr /bin /opt)

echo "WARNING: Script looks for packages for all files in "$DIRS > /dev/stderr
echo "This will be SLOW! It can run for up to O(10 hours)!" > /dev/stderr

MY_PID=$$
NP=4
TMP_FILE=(mktemp /tmp/find_lost_packages.$MY_PID)
for D in $DIRS; do
	# First time filtering through uniq saves a ton of output:
	find $D -iname "*" | xargs -n 1 -P $NP pkgfile -s | uniq >> $TMP_FILE
done
sort $TMP_FILE | uniq 

