

#--------------Expand.sh---------------------

#!/usr/bin/bsh

#set the disk partion location
location=$1

#set the capacity volume
#define by real requirement
capacity=1

#Step-01:Check the disk capacity
used=$(df -g| grep "$location" | awk {'print $4'} | cut -d '%' -f1)
echo "Before Expand Action , [ $location ] used is : $used \n"

#Step-02:Get Available vg 
vg_free=$(lsvg -o)
echo "Available VG is : $vg_free \n"

#Step-03:Get PP Size
ppsize=$(lsvg rootvg | grep "PP SIZE" | awk {'print $6 " " $7'})
ppsize_capacity=$(lsvg rootvg | grep "PP SIZE" | awk {'print $6'})

echo "PP Size is : $ppsize \n"
echo "ppsize value is :ppsize_capacity \n"

#Step-04:Get Free PPS 
freepps=$(lsvg rootvg | grep "FREE PPS" | awk {'print $6 " " $7 " " $8'})
echo "free pps is : $freepps"

#Step-05: Check the free value is ok or not
freepps_value=$(lsvg rootvg | grep "FREE PPS" | awk {'print $6'})

if [ $freepps_value -ge 0];then 
	echo "System Capacity Is Enough , GO !"
else
	echo "System Capacity Is Not Available, Please Double Check Again!!!"
fi


Step-06:Expand the value
expand_out=$(chfs -a size=+{capacity}G $location)

if [ $? == 0];then 
	echo "GOOD JOB!!!!Expand Action SUCCEED!!!!\n"
else
	echo "Expand Action FAILD, Please Double Check Again!!!"
fi

#Step-08:Check the capacity Again
used=$(df -g| grep "$location" | awk {'print $4'} | cut -d '%' -f1)
echo "After Expand Action , [ $location ] used is : $used \n"



