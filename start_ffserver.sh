#/bin/bash

CD=$(dirname $(readlink -f $BASH_SOURCE))
echo $CD

port=$1
if [ "$port" == "" ] ; then
        port=8090
fi

conf=/tmp/ffserver_$port.conf

cat > $conf << EOF
HTTPPort            8090
HTTPBindAddress     0.0.0.0
MaxHTTPConnections 200
MaxClients      100
MaxBandWidth    500000
CustomLog       -

<Feed camera.ffm>
File            /tmp/camera.ffm
FileMaxSize     200M
</Feed>

<Stream camera.mjpeg>
Feed camera.ffm
Format mpjpeg
VideoFrameRate 25
VideoIntraOnly
VideoBitRate 4096
VideoBufferSize 4096
VideoSize 640x560
VideoQMin 5
VideoQMax 51
NoAudio
Strict -1
</Stream>
EOF




ffserver -f $conf
