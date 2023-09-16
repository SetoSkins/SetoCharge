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
chmod 777 $MODDIR/system/EasterEgg.sh
chmod +x $MODDIR/system/SetoScreen
MODID="$(cat $(dirname "$0")/module.prop | grep "id=" | sed 's/id=//g')"
nohup $MODDIR/system/SetoScreen $MODID > /dev/null 2>&1 &