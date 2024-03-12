#!/bin/bash

# Mise à jour des paquets et installation de Bind9
sudo apt update
sudo apt install -y bind9 bind9utils bind9-doc

# Configuration des options de Bind9 pour autoriser les requêtes de tous les réseaux privés
cat << EOF | sudo tee /etc/bind/named.conf.options
options {
    directory "/var/cache/bind";

    // Ecouter sur toutes les interfaces
    listen-on { any; };

    // Autoriser les requêtes des réseaux privés suivants
    allow-query { 10.0.0.0/8; 172.16.0.0/12; 192.168.0.0/16; };

    dnssec-validation auto;

    // Ne pas écouter sur les adresses IPv6
    listen-on-v6 { none; };

    recursion yes;
};
EOF

# Configuration de la zone DNS avec support DNSSEC
echo 'zone "m2.dawan" {
    type master;
    file "/etc/bind/db.m2.dawan.signed";
    key-directory "/etc/bind/keys";
};' | sudo tee /etc/bind/named.conf.local

# Créer le répertoire pour les clés DNSSEC
sudo mkdir -p /etc/bind/keys

# Créer et remplir le fichier de zone db.m2.dawan
sudo bash -c 'cat > /etc/bind/db.m2.dawan << EOF
\$TTL    604800
@       IN      SOA     dns.m2.dawan. root.m2.dawan. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      dns.m2.dawan.
@       IN      A       192.168.33.20
dns     IN      A       192.168.33.20
pki     IN      A       192.168.33.21
web     IN      A       192.168.33.22
EOF'

# Générer les clés DNSSEC pour la zone
cd /etc/bind/keys
sudo dnssec-keygen -a NSEC3RSASHA1 -b 2048 -n ZONE m2.dawan
sudo dnssec-keygen -f KSK -a NSEC3RSASHA1 -b 4096 -n ZONE m2.dawan

# Signer la zone avec DNSSEC
cd /etc/bind
sudo dnssec-signzone -K keys -o m2.dawan -t db.m2.dawan

# Vérifier la configuration de Bind9
sudo named-checkconf
sudo named-checkzone m2.dawan db.m2.dawan.signed

# Redémarrer le service Bind9 pour appliquer les changements
sudo systemctl restart bind9

# Activer le service Bind9 au démarrage
sudo systemctl enable bind9

# Vérification finale du statut du service Bind9
sudo systemctl status bind9