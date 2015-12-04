while true
do
        now=$(date +"%m-%d-%Y")
        Rfile="/home/yesyayen/MonitorData/logs/RMonitor_Log_$now"
        Shellfile="/home/yesyayen/MonitorData/logs/ShellMonitor_Log_$now"

        boto-rsync -v -a $access -s $secret --ignore-empty /home/yesyayen/MonitorData/RMonitorData/ s3://vossm-datastore/RMonitorData/ >> "$Rfile"
        boto-rsync -v -a $access -s $secret --ignore-empty /home/yesyayen/MonitorData/ShellMonitorData/ s3://vossm-datastore/ShellMonitorData/ >> "$Shellfile"
        echo "waiting"  
        sleep 10       #sleep for 10 sec
done

