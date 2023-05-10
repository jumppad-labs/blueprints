#!/bin/sh

while [ ! -f /files/my_key ]
do
  sleep 2 # or less like 0.2
done

echo $(cat /files/my_key) >> /files/authorized_keys
chmod 600 /files/authorized_keys