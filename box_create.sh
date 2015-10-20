#!/bin/bash
#
# date 2015-08-25
#

###
# create box for vagrant
###


# get vm list from virtualbox
IFS=$'\n' ARR=(`VBoxManage list vms`)
for VALUE in "${ARR[@]}";
do 
    let I=I+1
    echo "$I) $VALUE";
done

read -p "select vm : " VM_NUM

if [ $VM_NUM -le $I ]
then
    VM_NAME=`VBoxManage list vms | sed -n "$VM_NUM"p | sed -e 's; .*$;;' | sed 's/\"//g'`
    echo "selected : $VM_NUM) $VM_NAME"

    ## create vagrant box
    echo "--- start vm packing"
    vagrant package --output $VAGRANT_HOME/box-image/$VM_NAME.box --base $VM_NAME
    echo "--- end vm packing"
else
    echo "less than $I"
fi

