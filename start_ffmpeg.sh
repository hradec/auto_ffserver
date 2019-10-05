#/bin/bash


CD=$(dirname $(readlink -f $BASHSOURCE))
echo $CD

port=$1
if [ "$port" == "" ] ; then
	port=8090
fi

ffmpeg -f video4linux2  -standard PAL  -s 720x560 -r 30 -i /dev/video0 http://localhost:$1/camera.ffm

