file2=$(ls /sys/class/power_supply/battery/*charge_current /sys/class/power_supply/battery/current_max /sys/class/power_supply/battery/thermal_input_current 2>>/dev/null|tr -d '\n')
file="/sys/class/power_supply/battery/constant_charge_current_max"
if [ ! -f "$file2" ] -o [ ! -f "$file" ]; then
echo "- 不支持你的设备"
exit 1
fi
Reserve() {
	echo "- 是否保留之前配置"
	echo "- 音量上键为保留"
	echo "- 音量下键为取消"
	key_click=""
	while [ "$key_click" = "" ]; do
		key_click="$(getevent -qlc 1 | awk '{ print $3 }' | grep 'KEY_')"
		sleep 0.2
	done
	case "$key_click" in
	"KEY_VOLUMEUP")
		echo "- 确认保留"
		sleep 1
		cp /data/adb/modules/SetoCharge/配置.prop /data/adb/配置.prop
		cp /data/adb/modules/SetoCharge/游戏名单.prop /data/adb/游戏名单.prop
		if [ ! -f "/data/adb/配置.prop" ]; then
			echo "- 正在持续写入保留配置文件 请耐心等待"
			for i in $(seq 1 60); do
				sleep 1
				if [ ! -f "/data/adb/配置.prop" ]; then
					cp /data/adb/modules/SetoCharge/配置.prop /data/adb/配置.prop
					if [ -f "/data/adb/配置.prop" ]; then
						break
					fi
				fi
			done
		fi
		if [ ! -f "/data/adb/游戏名单.prop" ]; then
			echo "- 正在持续写入保留配置文件 请耐心等待"
			for i in $(seq 1 60); do
				sleep 1
				if [ ! -f "/data/adb/游戏名单.prop" ]; then
					cp /data/adb/modules/SetoCharge/游戏名单.prop /data/adb/游戏名单.prop
					if [ -f "/data/adb/游戏名单.prop" ] || [ ! -f "/data/adb/modules/SetoCharge/游戏名单.prop" ]; then
						break
					fi
				fi
			done
		fi
		;;
	*)
		echo "- 取消保留"
		;;
	esac
}
if [ -d "/data/adb/modules/SetoCharge/" ]; then
	echo "- 检测到有备份配置 鉴定为更新模块"
Reserve
else
	echo "- 第一次安装本模块请看好说明"
fi
echo "- 配置在模块根目录"
echo "- 请卸载一切有关于改电流大小的模块 否则模块不会生效"
sleep 5
if [ ! -d "/data/adb/modules/SetoCharge/" ]; then
	am start -a 'android.intent.action.VIEW' -d 'https://hub.cdnet.run/' >/dev/null 2>&1
fi