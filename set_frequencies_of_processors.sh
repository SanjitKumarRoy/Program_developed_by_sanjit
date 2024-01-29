#!/bin/bash

##scaling_available_governors="performance powersave" ##Available frequencies##
##scaling_governor="performance" ##Processors current frequeny ##

for p in `seq 0 3`
do
	fileName="/sys/devices/system/cpu/cpu${p}/cpufreq/scaling_governor"
 	echo "performance" > $fileName ##Change cpu frequency##
# 	echo "powersave" > $fileName ##Change cpu frequency##
	cat $fileName ##Print scaling governer
done
