# Infraestrutura para o framework Cabrones

> Os servidores estão listados na ordem em que são iniciados.

1. Servidor `mysql`
   - Sistema operacional:
     - Linux Ubuntu
   - Serviços:
     - Banco de dados tipo MySQL: MariaDB
       - Possibilidade de configurar informações de autenticação.
   - Portas de rede:
     - 3306/tcp
2. Servidor `http`
   - Sistema operacional:
     - Linux Ubuntu
   - Serviços:
     - HTTP com PHP: Apache HTTP Server
       - Possibilidade de configurar certificado SSL.
     - FTP para deploy: vsftpd FTP Server
   - Portas de rede:
     - 80/tcp
     - 443/tcp
     - 20-21/tcp
     - 21100-21110/tcp

Use o comando a seguir para definir a senha: `docker-compose build --build-arg FTP_PASSWORD="minha-senha" --build-arg SSH_PASSWORD="minha-senha"`
Seguem a lista de argumentos configuráveis:
  - `HTTP_EMAIL`
  - `HTTP_DOMAIN`
  - `FTP_USER`
  - `FTP_PASSWORD`
  - `SSH_USER`
  - `SSH_PASSWORD`
  - `MYSQL_ROOT_USER`
  - `MYSQL_ROOT_HOST`
  - `MYSQL_ROOT_PASSWORD`
