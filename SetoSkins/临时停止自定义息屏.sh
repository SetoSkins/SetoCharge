file1=/data/adb/modules/SetoScreen/亮度配置.prop
killall SetoScreen > /dev/null
	a=$(grep "其他应用息屏时间" "$file1" | cut -d "=" -f2)
settings put system screen_off_timeout $a
echo "如果想恢复，只需要执行Service.sh即可。"