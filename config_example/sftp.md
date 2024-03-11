**Correction VSTPD 01 - sans SSL** https://www.digitalocean.com/community/tutorials/how-to-set-up-vsftpd-for-a-user-s-directory-on-debian-10

`dpkg-reconfigure adduser`  > Passer à NON

`adduser sammy`

`apt-get update` 
 
`apt-get install vsftpd`

`cp /etc/vsftpd.conf /etc/vsftpd.conf.backup`

`mkdir /home/sammy/ftp`
`chown nobody:nogroup /home/sammy/ftp/`

`chmod a-w /home/sammy/ftp`

`mkdir /home/sammy/ftp/files`
`chown sammy:sammy /home/sammy/ftp/files`

`echo "hello everyone" | tee /home/sammy/ftp/files/test.txt`

`nano /etc/vsftpd.conf`

> listen=NO
> listen_ipv6=YES
> anonymous_enable=NO
> local_enable=YES
> write_enable=YES
> dirmessage_enable=YES
> use_localtime=YES
> xferlog_enable=YES
> connect_from_port_20=YES
> 
> chroot_local_user=YES
> user_sub_token=$USER
> local_root=/home/$USER/ftp
> userlist_enable=YES
> userlist_file=/etc/vsftpd.userlist
> userlist_deny=NO
> secure_chroot_dir=/var/run/vsftpd/empty
> pam_service_name=vsftpd

Enfin, ajoutons notre utilisateur à /etc/vsftpd.userlist. 
Utilisez le `-a` pour ajouter au fichier :

`echo "sammy" | tee -a /etc/vsftpd.userlist`
 
`systemctl restart vsftpd`

`systemctl status vsftpd`

`tail -f /var/log/syslog`


**FTP avec SSL**

Utilisons opensslpour créer un nouveau certificat et utilisons le -days pour le rendre valide pendant un an. Dans la même commande, nous allons ajouter une clé RSA privée de 2048 bits. En définissant à la fois les indicateurs -keyout et -out sur la même valeur, la clé privée et le certificat seront situés dans le même fichier :

`openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/vsftpd.pem -out /etc/ssl/private/vsftpd.pem`

`nano /etc/vsftpd.conf`

> rsa_cert_file=/etc/ssl/private/vsftpd.pem
> rsa_private_key_file=/etc/ssl/private/vsftpd.pem
> ssl_enable=YES
> allow_anon_ssl=NO
> force_local_data_ssl=YES
> force_local_logins_ssl=YES
> ssl_tlsv1=YES
> ssl_sslv2=NO
> ssl_sslv3=NO
> require_ssl_reuse=NO
> ssl_ciphers=HIGH

`systemctl restart vsftpd`

Normalement depuis Filezilla vous devez voir apparaître un certificat.

Le traffic avec Wireshark est chiffré.