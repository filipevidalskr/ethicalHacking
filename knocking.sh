#!/bin/bash

#Here we can reproduce a malware techniche called "Door Knocking", once we'll check available doors on a server;
#Remember: this is for a vulnerability analysis and see if a 3HS is done and packages are been transmitted.
#PS: There's an echo "Port knocking done. Tryng to access door XXXX...". The XXXX is concerning the one we sent a SYN flag and receive an ACK

# IP from target server
ip="XX.XX.XX.XX"

#Door sequences for port knocking
portas=(XX XX XX XX)

echo "Starting port knocking..."
for porta in "${portas[@]}"; do
    echo "Knocking on the door $porta..."
    sudo hping3 --syn -c 1 -p $porta $ip >/dev/null 2>&1
    sleep 0.5 # Brief delay to assure a sequency
done

echo "Port knocking done. Tryng to access door XXXX..."

# Access the XXXX door banner using wget
banner=$(wget -T 1 -t 1 -w 0 $ip:XXXX -O - 2>/dev/null)

if [ -n "$banner" ]; then
    echo "Banner found in door XXXX"
    echo "$banner"
else
    echo "Fail to access door 1337. Check if port knocking was executed correctly."
    exit 1
fi
