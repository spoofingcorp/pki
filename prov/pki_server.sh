#!/bin/bash

# Ajout des entrées dans /etc/hosts
echo "192.168.33.20 dns.m2.dawan" | sudo tee -a /etc/hosts
echo "192.168.33.21 pki.m2.dawan" | sudo tee -a /etc/hosts
echo "192.168.33.22 web.m2.dawan" | sudo tee -a /etc/hosts

set -e  # Exit immediately if a command exits with a non-zero status.
set -x  # Print each command to stdout before executing it.

DOMAIN="m2.dawan"
HOSTNAME="pki.m2.dawan"

echo 'START of Install_stepCA.sh script' "$HOSTNAME" "$(hostname -I | awk '{print $1}')"

# Update resolv.conf
echo "[PKI 1] Updating resolv.conf"
{
    DNSIP=$(grep DNS /etc/hosts | awk '{print $1}')
    cat > /etc/resolv.conf << EOF
domain $DOMAIN
search $DOMAIN
nameserver 192.168.33.20
nameserver 8.8.8.8
EOF
} || { echo "Failed to update resolv.conf"; exit 1; }

# Install step-ca
echo "[PKI 2] Installing step-ca"
{
    wget -q https://dl.step.sm/gh-release/cli/doc-ca-install/v0.19.0/step-cli_0.19.0_amd64.deb && dpkg -i step-cli_0.19.0_amd64.deb
    wget -q https://dl.step.sm/gh-release/certificates/doc-ca-install/v0.19.0/step-ca_0.19.0_amd64.deb && dpkg -i step-ca_0.19.0_amd64.deb
} || { echo "Failed to install step-ca"; exit 1; }

# Configure step-ca
echo "[PKI 3] Configuring step-ca"
{
    echo "password" > /root/password.txt
    step ca init --ssh --deployment-type=standalone --name="Pki" --dns=$HOSTNAME --address=:8443 --provisioner=vagrant@$DOMAIN --password-file=/root/password.txt
} || { echo "Failed to configure step-ca"; exit 1; }

# Update the step path
mv $(step path) /etc/step-ca
sed -i "s|/root/.step|/etc/step-ca|g" /etc/step-ca/config/defaults.json
sed -i "s|/root/.step|/etc/step-ca|g" /etc/step-ca/config/ca.json

# Create a system user for step-ca
useradd --system --home /etc/step-ca --shell /bin/false step
chown -R step:step /etc/step-ca

# Setup systemd and start service
echo "[PKI 4] Configuring systemd and starting the service"
wget -q https://raw.githubusercontent.com/smallstep/certificates/master/systemd/step-ca.service
mv step-ca.service /etc/systemd/system/
export STEPPATH=/etc/step-ca
echo STEPPATH=/etc/step-ca > /etc/environment
systemctl daemon-reload
systemctl enable --now step-ca
mv /root/password.txt /etc/step-ca/

# Add ACME provisioner
step ca provisioner add acme --type ACME
systemctl restart step-ca.service

echo "step-CA installation and configuration complete."
