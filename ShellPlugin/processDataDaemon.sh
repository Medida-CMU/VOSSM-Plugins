#!/bin/bash

myPID=$$
system="Linux"
hardware=`uname -m`
ipaddress=`ifconfig wlan0 2>/dev/null|awk '/inet addr:/ {print $2}'|sed 's/addr://'`
user=`cat /var/lib/dbus/machine-id`
#stores the output of ps in file op1
	ps -A -o pid,command > op1
while :
do
	#gets the elapsed time of every process and stores it
	ps -A -o etime,pid,command > geteTime
	#checks for terminated process every (_ seconds + processing time)
	sleep 3
	#stores the output of ps in file op2
	ps -A -o pid,command > op2
	#diff between op1 and op2 to find the processes that are closed [SIGKILL] [SIGTERM] and store the output in op2_op1
	diff op2 op1 > op2_op1
	#stores the output of ps in file op1 - gets the process list before processing starts
	ps -A -o pid,command > op1
	#cat op2_op1

	k=1
	#reads op2_op1 line by line for processing
	while read line;do
		
		#checks the first character of diff line, if it belongs to file2 i.e. op1. "> - file2", "> - file1"
		if [ "${line:0:1}" == ">" ]
		then
			#should ignore the processes started by this program
			if [[ $line != *"pid,command"* ]]
			then
				#get the process name CMD
				process_name=`echo $line | cut -d ' ' -f 3`
				process_command=`echo $line | cut -d ' ' -f 3-`
				pid=`echo $line | cut -d ' ' -f 2`
				#get the record from geteTime
				total_time=`grep $pid" " < geteTime`
				#get the elapsed_time from the record
				elapsed_time=`echo $total_time | cut -d ' ' -f 1`
				success="false"

				versionInfo=`dpkg --status $process_name 2> /dev/null`
				if [[ $versionInfo == *"Version"* ]]
				then
					success="true"
				fi

				if [[ "$success" == "false" ]]
				then
					IFS='/' read -a myarray <<< $process_name
					tmpName=${myarray[${#myarray[@]}-1]}
					versionInfo=`dpkg --status $tmpName 2> /dev/null`
					if [[ $versionInfo == *"Version"* ]]
					then
						success="true"
						process_name=$tmpName
					fi
				fi
				if [[ "$success" == "true" ]]
				then
					version=`dpkg --status $process_name | grep ^Version`
					#put those information in a file
					# echo -n $process_name " - " >> processDaemon.log
					# echo $elapsed_time >> processDaemon.log
					# echo -n $process_command " - " >> processDaemonWhole.log
					# echo $elapsed_time >> processDaemonWhole.log
					echo '{"user" : "'$user'","system" : "'$system'","version" : "'$version'","hardware" : "'$hardware'", "package" : "'$process_name'", "duration" : "'$elapsed_time'", "ipaddress" : "'$ipaddress'"}' >> /home/yesyayen/MonitorData/shellJSON.log
				fi
			fi	
		fi
        	((k++))
	done < op2_op1

done
