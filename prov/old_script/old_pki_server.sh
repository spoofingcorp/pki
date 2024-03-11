#!/bin/bash

# Ajout des entrées dans /etc/hosts
echo "192.168.33.20 dns.m2.dawan" | sudo tee -a /etc/hosts
echo "192.168.33.21 pki.m2.dawan" | sudo tee -a /etc/hosts
echo "192.168.33.22 web.m2.dawan" | sudo tee -a /etc/hosts

# Installation de Easy-RSA
sudo apt-get update
sudo apt-get install -y easy-rsa

# Configuration de l'environnement Easy-RSA
EASYRSA_PKI="/etc/easy-rsa/pki"
EASYRSA_VARS_FILE="/etc/easy-rsa/vars"
sudo make-cadir /etc/easy-rsa

# Personnalisation de la configuration Easy-RSA
echo "set_var EASYRSA_REQ_COUNTRY    \"US\"" | sudo tee -a $EASYRSA_VARS_FILE
echo "set_var EASYRSA_REQ_PROVINCE   \"California\"" | sudo tee -a $EASYRSA_VARS_FILE
echo "set_var EASYRSA_REQ_CITY       \"San Francisco\"" | sudo tee -a $EASYRSA_VARS_FILE
echo "set_var EASYRSA_REQ_ORG        \"MyOrg\"" | sudo tee -a $EASYRSA_VARS_FILE
echo "set_var EASYRSA_REQ_EMAIL      \"admin@myorg.com\"" | sudo tee -a $EASYRSA_VARS_FILE
echo "set_var EASYRSA_REQ_OU         \"MyOrgUnit\"" | sudo tee -a $EASYRSA_VARS_FILE

cd /etc/easy-rsa

# Initialisation de l'autorité de certification PKI
sudo ./easyrsa init-pki

# Définition de la passphrase CA de manière non interactive
export EASYRSA_PASSIN="pass:7h!5IsACompl3x&P@ssphr@s3"
export EASYRSA_PASSOUT="pass:7h!5IsACompl3x&P@ssphr@s3"

# Création de la CA sans interaction (en utilisant la passphrase prédéfinie)
sudo ./easyrsa --batch build-ca nopass

echo "PKI Server setup is completed."
