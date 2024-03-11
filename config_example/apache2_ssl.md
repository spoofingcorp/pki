**____________________________________APACHE2 VHOST SSL____________________________________________**
Que ce soit pour Apache ou pour Nginx:
/etc/nginx/
/etc/apache2/

`sites-available` = site(s) disponible(s) non publié(s) par le serveur web, non accessible(s)
`sites-enabled` = site(s) actif(s) publié(s) par le serveur web, accessible (s)

Le serveur web ne rendra pas accessible votre site indique tant que le fichier de `sitexx.conf` n'est pas lié (ln -s pour NGINX) ou activé (a2ensite pour Apache2) dans `sites-enabled`
Seul le site par défaut → `default.conf` est actif et accessible lors de l'installation d'Apache ou Nginx

**Apache VHOST SSL**
https://httpd.apache.org/docs/2.4/fr/ssl/ssl_howto.html

**Générer un certificat auto-signé**
`openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/privat.key -out /etc/ssl/private/certificat.crt`


**#Ajouter un nouveau site dans Apache2**
`nano /etc/apache2/sites-available/siteXYZ.conf`       
                   
 <VirtualHost *:443>    
    ServerName siteXYZ.com
    DocumentRoot /var/www/html
    SSLEngine on
    SSLCertificateFile /etc/ssl/private/certificat.crt
    SSLCertificateKeyFile /etc/ssl/private/privat.key
</VirtualHost>

**##Droits pour les certificats**
chown -R www-data:www-data /etc/ssl/private

**##Activer le nouveau site**
`cd /etc/apache2/site-available/`
`a2enmod ssl`
`a2ensite siteXYZ.conf`

`systemctl restart apache2`

Débug:
`apache2ctl configtest`