#!/bin/bash

# Mise à jour des paquets et installation de Bind9
echo "Mise à jour des paquets et installation de Bind9..."
sudo apt-get update
sudo apt-get install -y bind9 bind9utils bind9-doc dnsutils

# Configuration des options de Bind9 pour autoriser les requêtes de tous les réseaux privés
cat << EOF | sudo tee /etc/bind/named.conf.options
options {
    directory "/var/cache/bind";

    // Ecouter sur toutes les interfaces
    listen-on { any; };

    // Autoriser les requêtes des réseaux privés suivants
    allow-query { 10.0.0.0/8; 172.16.0.0/12; 192.168.0.0/16; };

    // Ne pas écouter sur les adresses IPv6
    listen-on-v6 { none; };

    recursion yes;
};
EOF

# Configuration de Bind9 pour le domaine m2.dawan
echo "Configuration de Bind9 pour le domaine m2.dawan..."

# Créer le dossier pour les fichiers de configuration de la zone
sudo mkdir -p /etc/bind/zones

# Création du fichier de zone pour m2.dawan
cat <<EOF | sudo tee /etc/bind/zones/db.m2.dawan
\$TTL    604800
@       IN      SOA     ns1.m2.dawan. admin.m2.dawan. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      ns1.m2.dawan.
@       IN      A       192.168.33.20
dns     IN      A       192.168.33.20
pki     IN      A       192.168.33.21
web     IN      A       192.168.33.22

# Configuration du fichier named.conf.local
cat <<EOF | sudo tee -a /etc/bind/named.conf.local
zone "m2.dawan" {
    type master;
    file "/etc/bind/zones/db.m2.dawan";
    allow-transfer { none; };
};
EOF

# Générer les clés pour DNSSEC
echo "Génération des clés pour DNSSEC..."
sudo dnssec-keygen -a NSEC3RSASHA1 -b 2048 -n ZONE m2.dawan
sudo dnssec-keygen -a NSEC3RSASHA1 -b 2048 -n ZONE -f KSK m2.dawan

# Signer la zone avec les clés
echo "Signature de la zone..."
sudo dnssec-signzone -o m2.dawan -N INCREMENT /etc/bind/zones/db.m2.dawan

# Redémarrer Bind9 pour appliquer les changements
echo "Redémarrage de Bind9..."
sudo systemctl restart bind9

echo "Installation et configuration terminées."