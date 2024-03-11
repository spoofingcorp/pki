#!/bin/bash

# Ajout des entrées dans /etc/hosts
echo "192.168.33.20 dns.m2.dawan" | sudo tee -a /etc/hosts
echo "192.168.33.21 pki.m2.dawan" | sudo tee -a /etc/hosts
echo "192.168.33.22 web.m2.dawan" | sudo tee -a /etc/hosts

# Mise à jour des paquets et installation de Bind9
sudo apt-get update
sudo apt-get install -y bind9 bind9utils bind9-doc

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

# Configurer le fichier named.conf.local pour inclure la zone m2.dawan
echo 'zone "m2.dawan" {
    type master;
    file "/etc/bind/db.m2.dawan";
};' | sudo tee /etc/bind/named.conf.local

# Créer le fichier de zone db.m2.dawan
sudo touch /etc/bind/db.m2.dawan

# Remplir le fichier de zone avec les enregistrements DNS nécessaires
echo '
$TTL    604800
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
' | sudo tee /etc/bind/db.m2.dawan

# Vérifier la configuration de Bind9
sudo named-checkconf
sudo named-checkzone m2.dawan /etc/bind/db.m2.dawan

# Redémarrer le service Bind9 pour appliquer les changements
sudo systemctl restart bind9

# Activer le service Bind9 au démarrage
sudo systemctl enable bind9.service

# Vérification finale du statut du service Bind9
sudo systemctl status bind9.service
