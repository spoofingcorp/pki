# Projet PKI

**author:** BRUSSE Rémi

**mail:** rbrusse@dawan.formation

# Semaine LPI 303
https://www.lpi.org/our-certifications/exam-303-objectives

https://www.dawan.fr/formations/linux/linux-pour-les-experts/linux-securite-preparation-lpi-303

https://dev.to/techschoolguru/a-complete-overview-of-ssl-tls-and-its-cryptographic-system-36pd

## Infrastructure PKI
- LAB 01 - Infra PKI > Voir [Notice](./Notice.md)
- Rappel notions certificats > [Notions Certificat](./Certificats.md)

- Fondamentaux LPI 303-300 > [Fondamentaux LPI 303-300](./LPIC-3%20Exam_303-300_Security.md)


# Organisation de la semaine 

### Jour 1 : Introduction à la Sécurité des Systèmes
- Présentation générale des concepts de sécurité informatique
- Introduction à la cryptographie et aux certificats numériques (x.509, PKI)
- Utilisation de OpenSSL pour la génération de CSR (Certificate Signing Request) et CRT (Certificate Revocation List)
- Compréhension des principes de TLS et configuration d'Apache2 avec mod_ssl
- Discussion sur les vulnérabilités communes et les techniques de défense (ASLR, DEP, Chroot)
- Atelier pratique : configuration de TLS sur un serveur Apache2

### Jour 2 : Renforcement de la Sécurité des Services Réseau
- Introduction à DNSSEC et configuration de BIND9 pour la sécurisation des zones DNS
- Utilisation de SSH CA pour une authentification sécurisée et la gestion des clés SSH
- Apprentissage de l'utilisation de setfsacl et getfsacl pour la gestion des ACL (Access Control Lists) sur les systèmes de fichiers
- Présentation de SELinux et AppArmor pour renforcer la sécurité du système d'exploitation
- Configuration de Snort et OpenVAS pour la détection et la gestion des vulnérabilités
- Atelier pratique : configuration de DNSSEC sur un serveur BIND9

### Jour 3 : Gestion des Accès et des Identités
- Introduction à SSSD (System Security Services Daemon) et son intégration avec PAM (Pluggable Authentication Modules)
- Mise en place de zones de pare-feu (Firewall Zones) et configuration d'IPtables pour la segmentation réseau
- Configuration de Radius sur EVE-NG pour l'authentification à plusieurs facteurs
- Discussion sur LUKS (Linux Unified Key Setup) pour le chiffrement des disques et Secure Grub pour la sécurisation du démarrage
- Atelier pratique : mise en place de SSSD pour l'authentification des utilisateurs sur un serveur Linux

### Jour 4 : Défense Périmétrique et Détection d'Intrusion
- Utilisation d'IDS/IPS pour la détection et la prévention des intrusions
- Introduction à SIEM (Security Information and Event Management) et XDR (Extended Detection and Response) pour la gestion des événements de sécurité
- Configuration de EVE-NG pour le saut de VLAN avec Yersinia pour la simulation d'attaques réseau
- Discussion sur IPsec vs OpenVPN et Wireguard pour les VPN sécurisés
- Atelier pratique : configuration d'un IDS/IPS avec Snort

### Jour 5 : Sécurité Avancée et Gestion des Risques
- Mise en œuvre du chiffrement de données avec NFS chiffré
- Utilisation de techniques avancées de renforcement de la sécurité avec chroot et SELinux
- Discussion sur la gestion des accès aux fichiers avec setfsacl et getfsacl
- Présentation de techniques de sécurisation avancées avec LUKS et Secure Grub
- Atelier pratique : configuration de NFS chiffré et renforcement de la sécurité avec chroot et SELinux





