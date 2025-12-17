#!/bin/bash

cat /etc/hosts | while read ip nume rest
do
        if [[ "$ip" == \#* ]] || [[ -z "$ip" ]] || [[ "$nume" == "localhost" ]]
        then
                continue
        fi

 adresa_ip=$(nslookup "$nume" | grep "Address" | tail -n 1 | awk '{print $2}')

        if [[ -n "$adresa_ip" ]] && [[ "ip" != "$adresa_ip" ]]; then
                echo "Bogus IP for <$nume> in /etc/hosts!"
        fi
done
