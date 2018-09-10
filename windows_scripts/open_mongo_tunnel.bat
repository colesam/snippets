Plink.exe -ssh -2 -L localhost:8022:mongo.colesamdevelopment.com:22 -l colesam -i C:\Users\Sam\Documents\SSH\id_rsa.ppk mongo.colesamdevelopment.com

REM -2
REM 	Force use of SSH protocol version 2.
REM 
REM -L 	[srcaddr:]srcport:desthost:destport
REM 	Set up a local port forwarding: listen on srcport (or srcaddr:srcport if specified), and forward any connections over 
REM 	the SSH connection to the destination address desthost:destport. Only works in SSH.
REM 	
REM -l user
REM 	Set remote username to user.
REM 
REM -i path
REM 	Private key file for authentication.