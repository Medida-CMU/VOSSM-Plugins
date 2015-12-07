while true
do
        now=$(date +"%m-%d-%Y")
        nowTime=`date +%s%N`
        Rfile="/home/yesyayen/MonitorData/logs/RMonitor_Log_$now"
        Shellfile="/home/yesyayen/MonitorData/logs/ShellMonitor_Log_$now"

        boto-rsync -v -a $access -s $secret --ignore-empty /home/yesyayen/MonitorData/RMonitorData/ s3://vossm-datastore/RMonitorData/ >> "$Rfile"
        boto-rsync -v -a $access -s $secret --ignore-empty /home/yesyayen/MonitorData/ShellMonitorData/ s3://vossm-datastore/ShellMonitorData/ >> "$Shellfile"
        echo "waiting"  
        sleep 10       #sleep for 10 sec

         val=`[ -s /home/yesyayen/MonitorData/shellJSON.log ] || echo "empty"`
         if [[ $val != "empty" ]]
         then
         	`touch /home/yesyayen/MonitorData/ShellMonitorData/ShellData_$nowTime.log`
        	`cat /home/yesyayen/MonitorData/shellJSON.log > /home/yesyayen/MonitorData/ShellMonitorData/ShellData_$nowTime.log 2> /dev/null`
        	`echo -n "" > /home/yesyayen/MonitorData/shellJSON.log`
        fi
done