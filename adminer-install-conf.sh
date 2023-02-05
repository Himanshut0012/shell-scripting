#install adminer
sudo apt update
sudo apt upgrade
sudo apt install adminer
sudo a2enconf adminer
sudo systemctl reload apache2
systemctl reload apache2
mv /etc/apache2/ports.conf /etc/apache2/ports-main.conf

#adminer configration on port 81

sudo echo       'Listen 81' >> /etc/apache2/ports.conf
sudo echo   '<IfModule ssl_module>' >> /etc/apache2/ports.conf
sudo echo        'Listen 444' >> /etc/apache2/ports.conf
sudo echo   '</IfModule>' >> /etc/apache2/ports.conf
sudo echo   '<IfModule mod_gnutls.c>' >> /etc/apache2/ports.conf
sudo echo        'Listen 444' >> /etc/apache2/ports.conf
sudo echo   '</IfModule>' >> /etc/apache2/ports.conf
systemctl reload apache2