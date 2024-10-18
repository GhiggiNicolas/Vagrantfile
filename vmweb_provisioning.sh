apt-get update -y
apt-get upgrade -y

# Installazione di Apache
apt-get install -y apache2

# Installazione di PHP e moduli aggiuntivi
apt-get install -y php libapache2-mod-php php-mysql

# Installazione di Adminer
mkdir -p /var/www/html/adminer
wget "https://www.adminer.org/latest.php" -O /var/www/html/adminer/index.php

systemctl restart apache2