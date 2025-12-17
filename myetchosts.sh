#!/bin/bash

verificare() {
	local host=$1
	local ip_1=$2
	local dns_server=$3

	ip_2=$(dig @$dns_server $host +short)

	if [ "$ip_2"=="$ip_1" ]; then
		echo "[OK] $host rezolva catre $ip_1 folosind DNS $dns_server"
	else
		echo "[FAIL] $host: DNS-ul zice $ip_2, dar in fisier e $ip_1"
	fi
}

DNS_SERVER="8.8.8.8"

while read ip nume restul_liniei; do
	[[ "$ip" =~ ^#.*$ ]] || [[ -z "$ip" ]] && continue
	if [[ "$ip" == "127.0.0.1" || "$ip" == "::1" ]]; then
		continue
	fi
	verificare "$nume" "$ip" "$DNS_SERVER"
done < /etc/hosts
