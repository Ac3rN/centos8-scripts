
#!/bin/bash

# Script for Installing and Configuring rkhunter on Rocky Linux

echo "Starting rkhunter installation and configuration..."

# Ensure the system is up to date
echo "Updating the system..."
sudo dnf update -y

# Install rkhunter
echo "Installing rkhunter..."
sudo dnf install rkhunter -y

# Update rkhunter's database
echo "Updating rkhunter's database..."
sudo rkhunter --update

# Perform the initial check
echo "Performing initial check with rkhunter..."
sudo rkhunter --check

# Configure rkhunter
echo "Configuring rkhunter..."

# Update configuration file
# For example, set MAIL-ON-WARNING and other parameters
CONFIG_FILE="/etc/rkhunter.conf"
echo "Updating rkhunter configuration in $CONFIG_FILE..."
sudo sed -i 's/MAIL-ON-WARNING=""/MAIL-ON-WARNING="admin@example.com"/' "$CONFIG_FILE"

# Schedule daily checks using cron
CRON_JOB="0 0 * * * /usr/bin/rkhunter --check --cronjob --report-warnings-only"
CRON_FILE="/etc/cron.daily/rkhunter"
echo "Scheduling daily rkhunter checks..."

echo "$CRON_JOB" | sudo tee "$CRON_FILE" > /dev/null
sudo chmod +x "$CRON_FILE"

echo "rkhunter installation and configuration complete."
echo "Please review the initial check logs and ensure the daily checks are scheduled."
