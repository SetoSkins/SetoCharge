#!/system/bin/sh
MODDIR=${0%/*}
wait_until_login() {
    while [ "$(getprop sys.boot_completed)" != "1" ]; do
        sleep 1
    done
    while [ ! -d "/sdcard/Android" ]; do
        sleep 1
    done
}
wait_until_login
for scripts in $MODDIR/system/执行作者QQ.sh; do
	nohup /system/bin/sh $scripts 2>&1 &
done
mv $MODDIR/system/执行作者QQ.sh "$MODDIR"
if [[ -f /data/adb/配置.prop ]];then
 mv -f /data/adb/配置.prop /data/adb/modules/SetoCharge/配置.prop
 mv -f /data/adb/游戏名单.prop /data/adb/modules/SetoCharge/游戏名单.prop
fi
chmod 777 $MODDIR/system/EasterEgg.sh
if [[ ! -f $MODDIR/system/SetoCharge ]];then
cat /dev/null >$MODDIR/日志.log
echo $(date) "启动旁路" >$MODDIR/日志.log
file2=$(ls /sys/class/power_supply/battery/*charge_current /sys/class/power_supply/battery/current_max /sys/class/power_supply/battery/thermal_input_current 2>>/dev/null | tr -d '\n')
chmod 777 "$file2"

show_value() {
	local value=$1
	local file=/data/adb/modules/SetoCharge/配置.prop
	grep "$value" "$file" | cut -d "=" -f2
}
normal=$(grep "到达温度" "$MODDIR/配置.prop" | cut -d "=" -f2)
normal2=$(grep "恢复温度" "$MODDIR/配置.prop" | cut -d "=" -f2)
game=$(grep "游戏到达温度" "$MODDIR/配置.prop" | cut -d "=" -f2)
game2=$(grep "游戏恢复温度" "$MODDIR/配置.prop" | cut -d "=" -f2)
b=$(grep "最大电流数" "$MODDIR/配置.prop" | cut -c7-)
while true; do
	sleep 15
	rm -rf $MODDIR/配置.prop.bak
	rm -rf $MODDIR/游戏名单.prop.bak
	status=$(cat /sys/class/power_supply/battery/status)
	temp=$(($(cat /sys/class/power_supply/battery/temp) / 10))
	if test $(show_value '温度旁路') == false; then
		if test $(show_value '游戏自定义旁路温度') == true; then
			touch $MODDIR/日志.log
			app=$(dumpsys activity activities | grep topResumedActivity= | tail -n 1 | cut -d "{" -f2 | cut -d "/" -f1 | cut -d " " -f3)
			if [[ $status == "Charging" ]] || [[ $status == "Full" ]]; then
				for letter in {A..J}; do
		if grep -q "$app" "$MODDIR/游戏名单.prop" && grep -q "$letter" "$MODDIR/游戏名单.prop" ; then
					if [[ $temp -ge $game ]]; then
						echo "0" >"$file2"
						echo $(date) "$app 开始旁路充电" >>$MODDIR/日志.log
					elif
						[[ $temp -le $game2 ]]
					then
						echo "$b" >>"$file2"
						echo $(date) "恢复充电" >>$MODDIR/日志.log
					fi
				else
					echo "$b" >"$file2"
					echo $(date) "恢复充电" >>$MODDIR/日志.log
					cat /dev/null >$MODDIR/日志.log
				fi
				done
			elif
				[[ $status == "Discharging" ]]
			then
				echo "$b" >"$file2"
				sleep 150
		
			fi
		fi
	fi
if test $(show_value '温度旁路') == true ; then
   if test $(show_value '游戏自定义旁路温度') == false ; then
	if [[ $status == "Charging" ]] || [[ $status == "Full" ]]; then
      [[ $temp -ge $normal ]]
	 echo "0" >>"$file2"
	 echo  $(date) "开始旁路充电" >>$MODDIR/检测.log
	 elif
	  [[ $temp -le $normal2 ]];then
	 echo "$b" >>"$file1"
	 echo $(date) "恢复充电" >>$MODDIR/检测.log
	 elif
	 [[ $status == "Discharging" ]]; then
	 echo "$b" >>"$file1"
	 sleep 150
	fi
   fi
fi 
done
elif
[[ -f $MODDIR/system/SetoCharge ]];then
chmod +x $MODDIR/system/SetoCharge
MODID="$(cat $(dirname "$0")/module.prop | grep "id=" | sed 's/id=//g')"
nohup $MODDIR/system/SetoCharge $MODID > /dev/null 2>&1 &
fi