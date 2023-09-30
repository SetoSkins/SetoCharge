killall SetoCharge > /dev/null
file2=$(ls /sys/class/power_supply/battery/*charge_current /sys/class/power_supply/battery/current_max /sys/class/power_supply/battery/thermal_input_current 2>>/dev/null|tr -d '\n')
	echo "500000000" >"$file2"
echo "如果你想恢复，只需要执行service.sh即可。"