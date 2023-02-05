#!/usr/bin/sh
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
