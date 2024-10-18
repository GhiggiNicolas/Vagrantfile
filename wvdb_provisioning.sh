apt-get update -y
apt-get upgrade -y

# Installazione di MySQL
export DEBIAN_FRONTEND=noninteractive # Evita richieste di configurazione, usa valori predefiniti
apt-get install -y mysql-server

# Configurazione del database: creazione di un nuovo utente non root
mysql -e "CREATE USER 'webuser'@'%' IDENTIFIED BY 'Password&1';"
mysql -e "GRANT ALL PRIVILEGES ON *.* TO 'webuser'@'%';"
mysql -e "FLUSH PRIVILEGES;"

# Configurazione del bind address per permettere connessioni remote
sed -i 's/127.0.0.1/0.0.0.0/' /etc/mysql/mysql.conf.d/mysqld.cnf
systemctl restart mysql