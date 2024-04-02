#!/bin/zsh

# 開始IPアドレス
start_ip="192.168.34.0"

# 終了IPアドレス
end_ip="192.168.34.255"

# 開始IPアドレスの最後の数字を取得
start=$(echo $start_ip | awk -F'.' '{print $4}')

# 終了IPアドレスの最後の数字を取得
end=$(echo $end_ip | awk -F'.' '{print $4}')

# pingを送信する
for i in $(seq $start $end); do
    ip="$start_ip"
    ip=$(echo $ip | sed "s/\.[0-9]*$/.${i}/")

    echo "Pinging $ip"
    (
        ping -c 1 $ip > /dev/null &&
        echo "$ip is reachable"
    ) &!
done

# すべてのバックグラウンドジョブが終了するまで待機
wait

