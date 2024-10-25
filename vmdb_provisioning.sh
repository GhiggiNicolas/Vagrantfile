apt-get update -y
apt-get upgrade -y

# Installazione di MySQL
export DEBIAN_FRONTEND=noninteractive # Evita richieste di configurazione, usa valori predefiniti
apt-get install -y mysql-server

# Configurazione del database: creazione di un nuovo utente non root
mysql -e "CREATE USER 'webuser'@'%' IDENTIFIED BY 'Password&1';"
mysql -e "GRANT ALL PRIVILEGES ON *.* TO 'webuser'@'%';"
mysql -e "FLUSH PRIVILEGES;"

mysql -e "CREATE DATABASE mynote_db;"
mysql -e "CREATE TABLE mynote_db.types(id INT PRIMARY KEY AUTO_INCREMENT, name VARCHAR(25) NOT NULL);"
mysql -e "CREATE TABLE mynote_db.notes(id INT PRIMARY KEY AUTO_INCREMENT, title VARCHAR(25) NOT NULL, text VARCHAR(255), type_id INT, FOREIGN KEY (type_id) REFERENCES mynote_db.types(id));"
mysql -e "INSERT INTO mynote_db.types(name) VALUES('Importante'),('Personale'),('Lavoro');"
mysql -e "INSERT INTO mynote_db.notes(title, text, type_id) VALUES('Finire i compiti', 'Si devono finire i compiti al piu presto.', 1),('Fare la spesa','Il frigorifire e vuoto, mancano soprattuto le uova.',2),('Finire il progetto','Meglio finire il progetto se no il capo si arrabbia.',3);"

# Configurazione del bind address per permettere connessioni remote
sed -i 's/127.0.0.1/0.0.0.0/' /etc/mysql/mysql.conf.d/mysqld.cnf
systemctl restart mysql