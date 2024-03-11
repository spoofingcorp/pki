# NGINX SERVER BLOCK SSL
http://nginx.org/en/docs/http/configuring_https_servers.html

#Passer root
`sudo -i`

`apt-get update`

`apt-get install nginx`

## Créer un nouveau site NGINX
`nano /etc/nginx/sites-available/siteXYZ.conf`

```
server { 
  listen 443 ssl; 
  server_name siteXYZ.com; 
  root /var/www/html/; 
  ssl_certificate /etc/ssl/private/certificat.crt; 
  ssl_certificate_key /etc/ssl/private/privat.key; 
  ssl_protocols TLSv1 TLSv1.1 TLSv1.2; 
  ssl_ciphers HIGH:!aNULL:!MD5; 

location / { 
  index index.html index.htm index.html index.php index.nginx-debian.html; 

} 

}

```

##Publier un site Nginx site.conf grâce à un lien symbolique
`ln -s /etc/nginx/sites-available/siteXYZ.conf /etc/nginx/sites-enabled/siteXYZ.conf`

DROITS sur /VAR/WWW/HTML - WWW-DATA:WWW-DATA
`chown -R www-data:www-data /var/www/html`
`chmod -R 755 /var/www/html`

##Importer votre certifiat et la clef privée
`nano /etc/ssl/private/certificat.crt`
Copier votre certificat depuis notepad++  (clic droit dans nano)

`nano /etc/ssl/private/privat.key`
Copier votre clef privée depuis notepad++ (clic droit dans nano)


#Supprimer le site par défaut NGINX
`rm -r /etc/nginx/sites-enabled/default`

##N'oubliez pas d'ajouter dans /etc/hosts
`nano /etc/hosts`

```
127.0.0.1 localhost 
127.0.0.1 votre_nom_de_domaine.cloudns.xyz
```

#Vérifier la configuration
`nginx -t`

`systemctl restart nginx`

#Accéder à votre site web en HTTPS


Importer un site
Télécharger un site (comme si un dev vous l'avez communiqué)
https://www.free-css.com/free-css-templates

Copier l'adresse du lien du template que vous avez choisi
Avec WGET télécharger le site
`wget https://www.free-css.com/le_lien_du_template`

Dézipper le site
`apt install unzip
unzip le_site.zip`

Supprimer le site Pokedex
`rm  /var/www/html/*`

Déplacer le template dézipper vers /var/www/html
`cd /le_dossier_du_site_dezipper`
`mv * /var/www/html/`






**NGINX SERVER BLOCK SSL** 

http://nginx.org/en/docs/http/configuring_https_servers.html

**## Créer un nouveau site NGINX**
`nano /etc/nginx/sites-available/siteXYZ.conf  
`
server {
    listen              443 ssl;
    server_name         siteXYZ.com;
    root /var/www/html/;
    ssl_certificate     /etc/ssl/private/certificat.crt;
    ssl_certificate_key /etc/ssl/private/privat.key;
    ssl_protocols       TLSv1 TLSv1.1 TLSv1.2;
    ssl_ciphers         HIGH:!aNULL:!MD5;

location / {
    index index.html index.htm index.html inde.php index.nginx-debian.html;
}

}

**##Publier un site Nginx site.conf **
`ln -s /etc/nginx/sites-available/siteXYZ.conf /etc/nginx/sites-enabled/siteXYZ.conf`


**___DROITS sur /VAR/WWW/HTML  - WWW-DATA:WWW-DATA___**

`chown -R www-data:www-data /var/www/html`
`chmod -R 755 /var/www/html`


**##Importer votre certifiat et la clef privée (De Notepad++ vers Shell avec nano)**
`nano /etc/ssl/private/cert.crt`
`nano /etc/ssl/private/privat.key`

Droits pour les certificats
`chown -R www-data:www-data /etc/ssl/private `


**#Supprimer le site par défaut NGINX**
`rm -r /etc/nginx/sites-enabled/default`

**##Modifier l'index HTML par défaut**
`mv /var/www/html/index.nginx-debian.html  /var/www/html/index.html`

**##N'oubliez pas d'ajouter dans /etc/hosts**
`nano /etc/hosts`

127.0.0.1      localhost
127.0.0.1      votre_nom_de_domaine.cloudns.xyz

**#Vérifier la configuration**
`nginx -t`
`systemctl restart nginx`

**#Accéder à votre site web en HTTPS :)**