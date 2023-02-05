#SSL CONFIG
#DOMAIN=""
sudo apt install certbot 
sudo certbot certonly --standalone -d {DOMAIN} 
sudo ls /etc/letsencrypt/live/{DOMAIN}/ 
cd /etc/letsencrypt/live/{DOMAIN} 
sudo cp {cert,chain,privkey}.pem /opt/tomcat/conf/ 
sudo nano /opt/tomcat/conf/server.xml 

 <Connector port="8443" protocol="org.apache.coyote.http11.Http11NioProtocol"
               maxThreads="150" SSLEnabled="true">
        <SSLHostConfig>
            <Certificate certificateFile="conf/cert.pem"
                 certificateKeyFile="conf/privkey.pem"
                 certificateChainFile="conf/chain.pem" />
        </SSLHostConfig>
    </Connector>

sudo systemctl restart tomcat 