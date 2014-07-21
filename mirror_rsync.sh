#!/bin/bash

#rsync --progress -av --delete --delete-excluded --exclude "local*" --exclude "isos" --exclude "i386" rsync://198.60.22.13/centos/6.5/ /data/mirror/centos/
rsync --progress -av --delete --delete-excluded --exclude "local*" --exclude "isos" --exclude "i386" rsync://ftp.neowiz.com/centos/6.5/ /data/mirror/centos/6.5/
~                                                                                                             
~  