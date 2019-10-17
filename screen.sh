xrandr --newmode "1680x1050_60.00"  146.25  1680 1784 1960 2240  1050 1053 1059 1089 -hsync +vsync
sudo xrandr --addmode VGA-1 1680x1050_60.00
ss-redir -s 119.28.44.216 -p 25683 -l 9000 -k 12345678 -m aes-256-cfb -f /var/9000 -a nobody
ipset create ChinaIPs hash:net
ipset flush ChinaIPs
cat /srv/cn.zone | while read -r net; do
    ipset add ChinaIPs ${net}                                                                                          
done

iptables -t nat -F SHADOWSOCKS >/dev/null 2>&1
iptables -t nat -N SHADOWSOCKS >/dev/null 2>&1
iptables -t nat -A SHADOWSOCKS -d 0.0.0.0/8 -j RETURN
iptables -t nat -A SHADOWSOCKS -d 10.0.0.0/8 -j RETURN
iptables -t nat -A SHADOWSOCKS -d 127.0.0.0/8 -j RETURN
iptables -t nat -A SHADOWSOCKS -d 169.254.0.0/16 -j RETURN
iptables -t nat -A SHADOWSOCKS -d 172.16.0.0/12 -j RETURN
iptables -t nat -A SHADOWSOCKS -d 192.168.0.0/16 -j RETURN
iptables -t nat -A SHADOWSOCKS -d 224.0.0.0/4 -j RETURN
iptables -t nat -A SHADOWSOCKS -d 240.0.0.0/4 -j RETURN
iptables -t nat -A SHADOWSOCKS -d 119.28.44.216 -j RETURN # 这里要改下IP
iptables -t nat -A SHADOWSOCKS -p tcp -m set ! --match-set ChinaIPs dst -j DNAT --to 127.0.0.1:9000
iptables -t nat -A OUTPUT -j SHADOWSOCKS
exit 0
~
