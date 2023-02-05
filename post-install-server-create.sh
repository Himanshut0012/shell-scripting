#!/usr/bin/sh
# Author Himanshu Tripathi
# scripting for install java 11 ,
# install tomcat and set Envirnment variable
# install adminer and configure on port 81
# install mysql and create database and user and password
# Now set variable for DATABASE name and  ROOT and PASSWORD
# create random password
PASSWDDB="himanshu"
MAINDB="shubham"
ROOTST="tripathi"

sudo apt update 
sudo apt install default-jdk -y 
java -version

#create tomcat folder

sudo useradd -m -d /opt/tomcat -U -s /bin/false tomcat 
wget https://dlcdn.apache.org/tomcat/tomcat-10/v10.0.27/bin/apache-tomcat-10.0.27.tar.gz
sudo tar xzvf apache-tomcat-10*tar.gz -C /opt/tomcat --strip-components=1 
sudo chown -R tomcat:tomcat /opt/tomcat/ 
sudo chmod -R u+x /opt/tomcat/bin
 
#tomcat setup

sudo echo '[Unit]' >> /etc/systemd/system/tomcat.service 
sudo echo 'Description=Tomcat' >> /etc/systemd/system/tomcat.service 
sudo echo 'After=network.target' >> /etc/systemd/system/tomcat.service 
sudo echo '' >> /etc/systemd/system/tomcat.service 
sudo echo '[Service]' >> /etc/systemd/system/tomcat.service 
sudo echo 'Type=forking' >> /etc/systemd/system/tomcat.service 
sudo echo '' >> /etc/systemd/system/tomcat.service 
sudo echo 'User=tomcat' >> /etc/systemd/system/tomcat.service 
sudo echo 'Group=tomcat' >> /etc/systemd/system/tomcat.service 
sudo echo 'Environment="JAVA_HOME=/usr/lib/jvm/java-1.11.0-openjdk-amd64"' >> /etc/systemd/system/tomcat.service 
sudo echo 'Environment="JAVA_OPTS=-Djava.security.egd=file:///dev/urandom"' >> /etc/systemd/system/tomcat.service 
sudo echo 'Environment="CATALINA_BASE=/opt/tomcat"' >> /etc/systemd/system/tomcat.service 
sudo echo 'Environment="CATALINA_HOME=/opt/tomcat"' >> /etc/systemd/system/tomcat.service 
sudo echo 'Environment="CATALINA_PID=/opt/tomcat/temp/tomcat.pid"' >> /etc/systemd/system/tomcat.service 
sudo echo 'Environment="CATALINA_OPTS=-Xms512M -Xmx1024M -server -XX:+UseParallelGC"' >> /etc/systemd/system/tomcat.service 
sudo echo '' >> /etc/systemd/system/tomcat.service 
sudo echo 'ExecStart=/opt/tomcat/bin/startup.sh' >> /etc/systemd/system/tomcat.service
sudo echo 'ExecStop=/opt/tomcat/bin/shutdown.sh' >> /etc/systemd/system/tomcat.service
sudo echo '' >> /etc/systemd/system/tomcat.service 
sudo echo '[Install]' >> /etc/systemd/system/tomcat.service 
sudo echo 'WantedBy=multi-user.target' >> /etc/systemd/system/tomcat.service 
sudo systemctl daemon-reload 
sudo systemctl start tomcat.service 
sudo systemctl enable tomcat.service 
#sudo systemctl status tomcat.service  
sudo systemctl stop tomcat.service 

#install adminer

sudo apt update
sudo apt upgrade
sudo apt install adminer
sudo a2enconf adminer
sudo systemctl reload apache2

# adminer configration

mv /etc/apache2/ports.conf /etc/apache2/ports-main.conf
sudo echo       'Listen 81' >> /etc/apache2/ports.conf
sudo echo   '<IfModule ssl_module>' >> /etc/apache2/ports.conf
sudo echo        'Listen 444' >> /etc/apache2/ports.conf
sudo echo   '</IfModule>' >> /etc/apache2/ports.conf
sudo echo   '<IfModule mod_gnutls.c>' >> /etc/apache2/ports.conf
sudo echo        'Listen 444' >> /etc/apache2/ports.conf
sudo echo   '</IfModule>' >> /etc/apache2/ports.conf
sudo systemctl reload apache2
sudo systemctl start tomcat.service 
# install mysql

sudo apt update
sudo apt install mysql-server -y
sudo systemctl start mysql.service

# If /root/.my.cnf exists then it won't ask for root password
if [ -f /root/.my.cnf ]; then

            mysql -e "CREATE DATABASE ${MAINDB} /*\!40100 DEFAULT CHARACTER SET utf8 */;"
                mysql -e "CREATE USER ${ROOTST}@localhost IDENTIFIED BY '${PASSWDDB}';"
                    mysql -e "GRANT ALL PRIVILEGES ON ${MAINDB}.* TO '${ROOTST}'@'localhost';"
                        mysql -e "FLUSH PRIVILEGES;"

                        # If /root/.my.cnf doesn't exist then it'll ask for root password   
                else
#                           echo "Please enter root user MySQL password!"
#                               echo "Note: password will be hidden when typing"
#                                   read -sp rootpasswd
                                        mysql -uroot -p${PASSWDDB} -e "CREATE DATABASE ${MAINDB} /*\!40100 DEFAULT CHARACTER SET utf8 */;"
                                            mysql -uroot -p${PASSWDDB} -e "CREATE USER ${ROOTST}@localhost IDENTIFIED BY '${PASSWDDB}';"
                                                mysql -uroot -p${PASSWDDB} -e "GRANT ALL PRIVILEGES ON ${MAINDB}.* TO '${ROOTST}'@'localhost';"
                                                    mysql -uroot -p${PASSWDDB} -e "FLUSH PRIVILEGES;"
fi
