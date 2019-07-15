This is a simple script that uses pkgfile to determine which packages your Arch
Linux system likely had installed. This is useful in case you accidentally
forget to backup your /var directory and hence lose your Pacman cache.
The script takes a LONG time to run, proportional to the number of files in the
directories you scan, so be prepared to wait a half to a full day for it to be
done. 

I recommend writing the output of the script to a file, so that afterwards you
can "simply" run pacman -S $( find_lost_packages.out ). For files that can be
provided by more than one package, pkgfile returns them all so you will have to
decide for yourself which package(s) you do not want by manually removing them
from the output file and rerunning pacman.
