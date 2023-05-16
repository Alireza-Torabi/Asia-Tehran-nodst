#!/bin/bash

# create file for Tehran time zone configuration
cd ~
sudo touch tehran-time
sudo chmod 666 tehran-time

# add configuration
cat <<EOF | sudo tee -a tehran-time
# Zone  NAME          GMTOFF  RULES FORMAT [UNTIL]
Zone    Tehran-nodst  3:25:44 -     LMT    1916
                      3:25:44 -     TMT    1946    # Tehran Mean Time
                      3:30    -     IRST   1977 Nov
                      4:00    -     IRST   1979
                      3:30    -     IRST
EOF

# create timezone configuration
sudo zic -d . tehran-time

# copy configuration to system timezone folder
sudo cp Tehran-nodst /usr/share/zoneinfo/Asia/

# backup current timezone configuration
sudo mv /etc/localtime /etc/localtime.backup

# create symbolic link to new timezone configuration
sudo ln -s /usr/share/zoneinfo/Asia/Tehran-nodst /etc/localtime

# remove temporary file
sudo rm tehran-time

# prompt for NTP server address
echo "Enter NTP server address (e.g. pool.ntp.org): "
read ntp_server

# add NTP server to timesyncd.conf
sudo sed -i "s/#NTP=/NTP=$ntp_server/" /etc/systemd/timesyncd.conf

# restart timesyncd service
sudo systemctl restart systemd-timesyncd.service
