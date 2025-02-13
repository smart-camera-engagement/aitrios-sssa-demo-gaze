function backup_file_name() { 
 echo $1"_bak_"`date "+%Y%m%d_%H%M%S"` 
} 

function diff_file() { 
 echo "" 
 diff $diff_switch $1 $2 
 echo "" 
} 

sudo apt-get install chkconfig

#
# Disable SSH password check
#
dest_file=/etc/pam.d/common-session
bak_file=`backup_file_name $dest_file`
sudo cp $dest_file $bak_file
sudo sed -i 's/.*pam_chksshpwd.so/#&/g' $dest_file
diff_file $bak_file $dest_file 

#
# Disable Wi-Fi/Bluetooth
# Configure LED
#
dest_file=/boot/firmware/config.txt
bak_file=`backup_file_name $dest_file` 
sudo cp $dest_file $bak_file

# Disable Bluetooth
sudo systemctl disable hciuart
#echo "dtoverlay=disable-bt" | sudo tee -a /boot/firmware/config.txt

# Disable Wi-Fi
#echo "dtoverlay=disable-wifi" | sudo tee -a /boot/firmware/config.txt
# Change LED for heart beat

if ! grep -q "dtparam=pwr_led_trigger=heartbeat" $dest_file ; then 
  cat <<EOL | sudo tee -a $dest_file
[all]
dtoverlay=disable-wifi
dtoverlay=disable-bt
dtparam=pwr_led_trigger=heartbeat
EOL
fi

#
# Remove Swap File
# to check Swap file run 'free -h'
sudo swapoff --all && \ 
sudo apt purge -y --auto-remove dphys-swapfile && \ 
sudo rm -fr /var/swap 

#
# Mount tmp folder to RAM disk
# to check run 'df -h'
#
dest_file=/etc/fstab
bak_file=`backup_file_name $dest_file`
sudo cp $dest_file $bak_file
add_str1="tmpfs /tmp tmpfs defaults,size=32m,noatime,mode=1777 0 0"
add_str2="tmpfs /var/tmp tmpfs defaults,size=16m,noatime,mode=1777 0 0"
add_str3="tmpfs /var/log tmpfs defaults,size=32m,noatime,mode=0755 0 0" 

if ! grep -q "$add_str1" $dest_file ; then 
  cat <<EOL | sudo tee -a $dest_file 
$add_str1 
$add_str2 
$add_str3 
EOL
fi

#
# Reduce logs
#
dest_file=/etc/rsyslog.conf
bak_file=`backup_file_name $dest_file`
sudo cp $dest_file $bak_file
sudo sed -i 's/.*pam_chksshpwd.so/#&/g' $dest_file
diff_file $bak_file $dest_file 

sudo apt-get autoremove -y python3-pygame man manpages galculator

sudo reboot

# remove files after reboot
# sudo rm -rf /tmp/*
# sudo rm -rf /var/tmp/*
# sudo rm -rf /var/log/*