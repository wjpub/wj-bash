#!/bin/bash

# define username:password, separate by colon, only use [a-Z0-9:]
vsftpdusers=(
    'vsftpd_admin:deepwise'
    'vsftpd_user:deepwise'
)
# define vsftpd data root path
vsftpd_datapath='/data1/vsftpd'

# check username password is valid
if [ ${#vsftpdusers[@]} -eq 0 ]; then 
    echo "please config vsftpd username and passwd"
fi
for user_passwd_str in ${vsftpdusers[@]}; do
    str_check=`echo "$user_passwd_str" | grep "^[a-Z0-9_]\{6,\}\+[:][a-Z0-9_]\{6,\}\+$"`
    if [ "$user_passwd_str" != "$str_check" ]; then
        echo "vsftpdusers config item '$user_passwd_str' err. should be this pattern 'username:password' , and match '^[a-Z0-9_]\+[:][a-Z0-9_]\+$' ."
    fi
done
echo "check username and password config pass."

# check data path exist
if [ ! -d "$vsftpd_datapath" ]; then
    sudo mkdir -p $vsftpd_datapath
    if [ -d "$vsftpd_datapath" ];then
        echo "vsftpd datapath create succ."
    else
	echo "vsftpd datapath create fail."
	exit 1
    fi
else
    echo "vsftpd datapath already exist."
fi

# install vsftp service
sudo apt-get install -y vsftpd libpam-pwdfile apache2-utils

#config vsftpd service
sudo mv /etc/vsftpd.conf /etc/vsftpd.conf.bak
sudo touch /etc/vsftpd.conf
sudo echo 'listen=YES
anonymous_enable=NO
local_enable=YES
write_enable=YES
local_umask=022
nopriv_user=vsftpd
virtual_use_local_privs=YES
guest_enable=YES
user_sub_token=$USER
local_root=/data1/vsftpd/$USER
chroot_local_user=YES
hide_ids=YES
guest_username=vsftpd
# reserve TCP ports 2121-2142 for passive FTP
pasv_enable=YES
pasv_min_port=2121
pasv_max_port=2142
chroot_list_enable=YES' > /etc/vsftpd.conf

# create system user vsftpd without shell power
sudo useradd --home /home/vsftpd --gid nogroup -m --shell /bin/false vsftpd

# create vsftpd user config info path
if [ ! -d "/etc/vsftpd" ]; then
    sudo mkdir /etc/vsftpd
fi
# create user auth info file
if [ ! -f "/etc/vsftpd/ftpd.passwd" ];then
    sudo touch /etc/vsftpd/ftpd.passwd
fi


for user_passwd_str in ${vsftpdusers[@]}; do
    user_passwd_arr=(${user_passwd_str//:/ })
    username=${user_passwd_arr[0]}
    password=${user_passwd_arr[1]}
    sudo htpasswd -db /etc/vsftpd/ftpd.passwd $username $password
    if [ $user_passwd_str == ${vsftpdusers[0]} ]; then
        echo "config vsftpd Administrator user --> username: $username , password: $password ."
        sudo touch /etc/vsftpd.chroot_list
	sudo echo $username >> /etc/vsftpd.chroot_list
	sudo echo $password >> /etc/vsftpd.chroot_list
    else
        echo "config vsftpd Normal upload user --> username: $username , password: $password ."
    fi

    # create user uplaod dir
    if [ ! -d "$vsftpd_datapath/$username" ]; then
        sudo mkdir "$vsftpd_datapath/$username"
    fi
    if [ ! -d "$vsftpd_datapath/$username/upload" ]; then
        sudo mkdir "$vsftpd_datapath/$username/upload"
    fi
    sudo chmod -w "$vsftpd_datapath/$username"
    sudo chmod -R 755 "$vsftpd_datapath/$username/upload"
    sudo chown -R vsftpd:nogroup "$vsftpd_datapath/$username" 
done

# config vsftpd user pam
sudo mv /etc/pam.d/vsftpd /etc/pam.d/vsftpd.bak
sudo touch vim /etc/pam.d/vsftpd
sudo echo 'auth required pam_pwdfile.so pwdfile /etc/vsftpd/ftpd.passwd
account required pam_permit.so' > /etc/pam.d/vsftpd

# restart vsftpd service
sudo /etc/init.d/vsftpd restart

# open ftp port: 21
ufw allow 21
ufw reload
echo "open ftp port: 21"

# install vsftpd done
echo "install vsftpd done ."
exit 0
