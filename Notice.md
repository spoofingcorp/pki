# LAB - Infrastructure PKI  :rocket:  :broccoli: :oden: :dango: 

# Prérequis infra Vagrant - Infrastructure PKI

### Prérequis Virtualbox
- Télécharger et installer Virtualbox
- virtualbox : https://www.virtualbox.org/wiki/Downloads


- Téléchargez l'extension pack Virtualbox pour votre version de VB **Oracle_VM_VirtualBox_Extension_Pack-7.0.XXX** , ainsi que l'ISO **VBoxGuestAdditions_7.0.XXX.iso**
- Importer l'extension pack Virtualbox, utiliser `Ctrl+T` pour y accéder et importer > `Oracle_VM_VirtualBox_Extension_Pack-7.0.12.vbox-extpack`
- Importer dans le gestionnaire de média, utiliser `Ctrl+D` pour y accéder et ajouter l'iso > `VBoxGuestAdditions_7.0.XXXX.iso`

- Télécharger et installer Vagrant
- vagrant : https://developer.hashicorp.com/vagrant/downloads


### Prérequis Vagrant

- Créer un dossier dans votre répertoire perso Windows - `vagrant-conf`
- Cloner le dépôt Git sur votre PC Windows
- Ouvrir le dossier` vagrant-conf` avec **VScode**
- Étudier le fonctionnement du fichier Vangrantfile (que va-t-il déployer ?)
- Se placer dans le path du répertoire comportant le vangrantfile en CMD ou PowerShell 
- Lancer la commande `vagrant up`
- Accepter les pop-up UAC Windows pour Virtualbox

## Services
- Se référer au schéma pour les IP et tester les services de l'infrastructure.

## Infrastructure

L'infrastructure comporte 3 serveurs : enregistré sur le domaine ais-wf3.local

- dns : 192.168.33.20
- pki : 192.168.33.21
- web : 192.168.33.22


Vous pouvez vous connecter en SSH avec la commande Vagrant SSH.
`vagrant ssh dns_server`
`vagrant ssh pki_server`
`vagrant ssh web_server`



### DNS

Utilisé pour la résolution DNS de domaine sur l'environement.
Configurer votre carte réseau physique avec le DNS 192.168.33.20. :warning:

### PKI

l'autorité de certification éxecute Easy-RSA.

La CA est configuré pour pouvoir emmetre des certificats SSL

Le certificat racine de cette CA est disponible dans /etc/step-ca/certs

### WEB

Le serveur web execute un serveur Apache2 configuré avec le domaine http://web.m2.dawan

## Exercice

Une fois l'infrastructure déployée avec Vagrant, changer le DNS de votre carte réseau :warning:
Sur votre machine hôte physique, configurer en serveur dns primaire 192.168.33.20


### Test HTTP
- Se rendre sur l'url http://web.m2.dawan
- Faite une capture du traffic à l’aide de wireshark.

- Mettre en place SSL sur le serveur web à l'aide de Certbot et de votre autorité PKI.
- Tester la connection en https:// 
- Que constatez vous ? 
- Comment résoudre **le problème rencontré**

## Solution

### Sur le serveur PKI :

```
sudo su -
cd /etc/step-ca/certs/

ls -l

total 16
\-rw------- 1 step step 660 Dec 8 13:06 intermediate_ca.crt
\-rw------- 1 step step 603 Dec 8 13:06 root_ca.crt
```

### Sur le serveur Web :
Modifier la config du server SSH du serveur Web
```
sed -i 's/ChallengeResponseAuthentication no/ChallengeResponseAuthentication yes/g' /etc/ssh/sshd_config
```

### Sur le serveur PKI :
Copier le CA sur le serveur web à partir du serveur PKI
```
scp root_ca.crt vagrant@192.168.33.22:/vagrant

root_ca.crt 100% 603 1.0MB/s
```



### Sur le serveur WEB :

```
sudo su -
mv /vagrant/root_ca.crt /usr/local/share/ca-certificates/pki_root_ca.crt
update-ca-certificates

Updating certificates in /etc/ssl/certs...
1 added, 0 removed; done.
Running hooks in /etc/ca-certificates/update.d...
done
```

```
certbot --apache --server https://pki.m2.dawan:8443/acme/acme/directory

Enter email address (used for urgent renewal and security notices) (Enter ’c’ to
cancel): rbrusse@m2.dawan
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Please read the Terms of Service at None. You must agree in order to register
with the ACME server at https://pki.m2.dawan:8443/acme/acme/directory
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
(A)gree/(C)ancel: A

Would you be willing to share your email address with the Electronic Frontier
Foundation, a founding partner of the Let’s Encrypt project and the non-profit
organization that develops Certbot? We’d like to send you email about our work
encrypting the web, EFF news, campaigns, and ways to support digital freedom.
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
(Y)es/(N)o: N

Which names would you like to activate HTTPS for?
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
1: m2.dawan
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Select the appropriate numbers separated by commas and/or spaces, or leave input
blank to select all options shown (Enter ’c’ to cancel): 1
Obtaining a new certificate
Performing the following challenges:
http-01 challenge for m2.dawan
Enabled Apache rewrite module
Waiting for verification...
Cleaning up challenges
Created an SSL vhost at /etc/apache2/sites-available/web-le-ssl.conf
Enabled Apache socache_shmcb module
Enabled Apache ssl module
Deploying Certificate to VirtualHost /etc/apache2/sites-available/web-le-ssl.conf
Enabling available site: /etc/apache2/sites-available/web-le-ssl.conf

Please choose whether or not to redirect HTTP traffic to HTTPS, removing HTTP access.
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
1: No redirect - Make no further changes to the webserver configuration.
2: Redirect - Make all requests redirect to secure HTTPS access. Choose this for
new sites, or if you’re confident your site works on HTTPS. You can undo this
change by editing your web server’s configuration.

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Select the appropriate number [1-2] then [enter] (press ’c’ to cancel): 2
Enabled Apache rewrite module
Redirecting vhost in /etc/apache2/sites-enabled/web.conf to ssl vhost in /etc/apache2/sites-
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Congratulations! You have successfully enabled https://m2.dawan
You should test your configuration at:
https://www.ssllabs.com/ssltest/analyze.html?d=m2.dawan
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
IMPORTANT NOTES:
- Congratulations! Your certificate and chain have been saved at:
/etc/letsencrypt/live/web.m2.dawan/fullchain.pem
Your key file has been saved at:
/etc/letsencrypt/live/web.m2.dawan/privkey.pem
Your cert will expire on 2022-12-09. To obtain a new or tweaked
version of this certificate in the future, simply run certbot again
with the "certonly" option. To non-interactively renew *all* of
your certificates, run "certbot renew"
- Your account credentials have been saved in your Certbot
configuration directory at /etc/letsencrypt. You should make a
secure backup of this folder now. This configuration directory will
also contain certificates and private keys obtained by Certbot so
making regular backups of this folder is ideal.

```

## Test HTTPS


Lancer une capture de traffic pour constater le chiffrement des réquêtes du formualaire https://web.m2.dawan/

- Quel protocole est utilisé ?

Normalement vous devez voire du TLS 1.3. Si ce n’est pas le cas, votre navigateur n’est pas a jour ou est mal configuré

Dans Chrome, taper > chrome://flags/#tls13-variant




## Rendu

- En tant qu'ingénieur Cyber, vous préconisez des axes d'améliorations concernant la sécurisation de l'infrastruture PKI.


## Notation & critère d'évaluation

- Clarté du document, sommaire, titre, sous-titre, en-tête, pied de page... [5 points]
- Pouvoir rédactionnel et de synthèse [5 points]
- Captures des configurations + capture du recettage [5 points]
- Respect des consignes et autonomie [5 points]
- Dead-line (17/03/2024 à 11:59 pm) [Eliminatoire > 0/20 si non rendu ou hors délai, rattrapage nécessaire]


# Exemple du plan du rendu 

- Page de garde
- Sommaire
- Contexte
- Public cible
- Infrastructure
- Schéma
- Solution sécurisation SSH 
/ recettage solution
- Solution sécurisation SFTP 
/ recettage solution
- Solution sécurisation HTTPD
/ recettage solution
- Préconisation sécurisation de l'infrastructure
- Conclusion