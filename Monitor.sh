#--------------------------Monitor.sh---------------------------------

#!/usr/binh
flag=$1
#Step-01:Get the used disk information
echo "------------Monitor Action Start----------------------"

current_time=$(date | awk {'print $6"-"$2"-"$3"-"$4'})
echo "Current Time is :$current_time"

partion_useage=$(df -g |grep -v '%Used' | grep -v '-' | awk {'print $4'} | cut -d '%' -f1)

i=0
for use in $partion_useage
do
	i=$((i+1))
	partion_name=$(df -g | grep -v '%Used' | grep -v '-' | awk {'print $7'| sed -n ${i}p})
	echo "partion Name is : $partion_name"
	
	if [ $use -ge $flag];then
		echo "ATTENTION!!!!\n [ $partion_name ] Disk Useage is [ $use % ] Greater than [ $flag ] : FAILD, Please Pay More Attention \n
				We Need Expand Action"
				
				sleep 5
				#Expand Action 
				echo "Disk Partition Expand Action Start \n"
				sh Expand.sh $partion_name
				echo "Disk Partition Expand Action End \n"
				sleep 5
	else
		echo "[ $partion_name ] used [ $used %] ,Don't Need Expand Action :PASS \n"
	fi
done

current_time=$(date | awk {'print $6"-"$2"-"$3"-"$4'})
echo "Current Time is :$current_time"

echo "------------------Monitor Action Done--------------------------"
