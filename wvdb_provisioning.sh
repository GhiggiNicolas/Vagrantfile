apt-get update -y
apt-get upgrade -y

# Installazione di MySQL
# export DEBIAN_FRONTEND=noninteractive # Evita richieste di configurazione, usa valori predefiniti
apt-get install -y mysql-server

# Configurazione del database: creazione di un nuovo utente non root
mysql -e "CREATE USER 'webuser'@'%' IDENTIFIED BY 'Password&1';"
mysql -e "GRANT ALL PRIVILEGES ON *.* TO 'webuser'@'%';"
mysql -e "FLUSH PRIVILEGES;"

systemctl restart mysql