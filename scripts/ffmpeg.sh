#!/bin/sh

today=`date '+%Y-%m-%d'`
snapshot_dir="./snapshot/$today"
mkdir -p $snapshot_dir

# 修改为自己的uproxy配置的地址和端口
uproxy_host="10.0.0.1"
uproxy_port="10001"
uproxy_url="http://$uproxy_host:$uproxy_port/rtp"

function screenshot() {
  rtsp_ip=$1
  now=`date '+%Y-%m-%d %H:%M:%S'`
  echo "[$now] $rtsp_ip"
  # 尝试截图，并自动结束长时间未能截图的进程，实现自动轮训下一个IP截图
  ffmpeg -t 3 -i "$uproxy_url/$rtsp_ip:5146/" -f image2 -vframes 3 -loglevel quiet $snapshot_dir/$rtsp_ip.jpeg
}

# 239.77 网段
for i in 0 1 
do
  for j in {1..255}
  do
    rtsp_ip="239.77.$i.$j"
    screenshot $rtsp_ip
  done
done

# 239.253.43 网段
for i in {1..255}
do
  rtsp_ip="239.253.43.$i"
  screenshot $rtsp_ip
done

# 239.0 网段
for i in 0 10
do
  for j in {1..255}
  do
    rtsp_ip="239.0.$i.$j"
    screenshot $rtsp_ip
  done
done
