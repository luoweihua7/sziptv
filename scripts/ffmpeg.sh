#!/bin/sh

today=`date '+%Y-%m-%d'`
snapshot_dir="./snapshot/$today"
mkdir -p $snapshot_dir

# 修改为自己的uproxy配置的地址和端口
uproxy_host="10.0.0.1"
uproxy_port="10001"

for i in {0..1}
do
  for j in {1..255}
  do
    now=`date '+%Y-%m-%d %H:%M:%S'`
    echo "[$now] 239.77.$i.$j"
    # kill ffmpeg after 15 seconds
    timeout -k 10 15 ffmpeg -i "http://$uproxy_host:$uproxy_port/rtp/239.77.$i.$j:5146/" -f image2 -vframes 3 -loglevel quiet $snapshot_dir/239_77_$i\_$j.jpeg
  done
done


