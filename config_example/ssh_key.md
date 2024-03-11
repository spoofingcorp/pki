**Configuration d'une clef SSH pour les serveurs Ubuntu/Debian (GNU/Linux)**

Sur la VM Linux, se placer dans le répertoire SSH
`cd /root/.ssh`

Si le répertoire n'existe pas
`mkdir /root/.ssh`
`cd /root/.ssh`

Générer une clef SSH, garder le path et le nom par défaut id_rsa
`ssh-keygen`

Ensuite, ajoutez la clé publique au fichier authorized_keys en saisissant ce qui suit :
`cat /root/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys`

Appliquer une permissions sur le dossier 700 
`chmod -R 700 /root/.ssh/` 

**Sur votre poste Windows**, importer la clef privée avec SCP dans votre dossier utilisateur Windows:

`scp root@192.168.1.14:/root/.ssh/id_rsa "C:\Users\votre_user_windows\.ssh\clefdeb01"`  

*(Adapter IP et Path aux besoins)*

Une fois la clef privé importé sur votre machine Windows, il va falloir aller modifier le fonctionnement du service SSH sur la VM Linux:
`nano /etc/ssh/sshd_config -c`

**Désactiver l'authentification par mot de passe et n'accepter que l'authentification par certificat**
Dé-commenter la ligne 34 et changer la valeur par `PermitRootLogin without-password`
Ajouter une ligne à la suite avec la valeur `PasswordAuthentication no`

Redémarrer le service SSH
`systemctl restart ssh `

**Pour se connecter depuis Windows Terminal:**
`ssh -i "C:\Users\votre_user_windows\.ssh\clefdeb01" root@192.168.1.XXX`


Infos extensions: 
`id_rsa` = clef privée SSH
`id_rsa.pub` = clef public SSH   `cat /root/.ssh/id_rsa.pub > ~/.ssh/authorized_keys`


_____De Windows vers Linux______

https://www.youtube.com/watch?v=ORks4JXxJp0

-------------------
Windows
-------------------

ssh-keygen -b 4096

(mettre à jour ci-dessous avec votre [dossier utilisateur], [utilisateur] et [hôte])

scp C:\Users\[dossier utilisateur]\.ssh\id_rsa.pub [utilisateur]@[hôte] :~/.ssh



-------------------
LINUX
-------------------


mkdir .ssh

chmod 700 .ssh

chmod 700 clés_autorisées

`cat /root/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys`

rm id_rsa.pub

sudo nano /etc/ssh/sshd_config
Dé-commenter la ligne 34 et changer la valeur par `PermitRootLogin without-password`
Ajouter une ligne à la suite avec la valeur `PasswordAuthentication no`

sudo systemctl redémarrer ssh

