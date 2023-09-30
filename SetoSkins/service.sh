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
chmod +x $MODDIR/system/SetoCharge
MODID="$(cat $(dirname "$0")/module.prop | grep "id=" | sed 's/id=//g')"
nohup $MODDIR/system/SetoCharge $MODID > /dev/null 2>&1 &