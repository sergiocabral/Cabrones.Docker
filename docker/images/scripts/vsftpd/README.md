# vsftpd FTP Server

Script para **instalação e configuração** inicial do vsftpd FTP Server.

## Dependências

O script `run.sh` depende de...

1. Uma instalação do Linux Ubuntu.
2. Dos seguintes arquivos nesta pasta:
   - `vsftpd`
   - `vsftpd.conf`

## Tarefas executadas

- Instalação do **vsftpd FTP Server**.
- **Backup** de arquivos originais.
  - `/etc/vsftpd.conf` para `/etc/vsftpd.conf.original`.
  - `/etc/pam.d/vsftpd` para `/etc/pam.d/vsftpd.original`.
- Escrita dos **arquivos de configuração** `abaixo com base no arquivo de mesmo nome nesta pasta:
  - `/etc/vsftpd.conf`
  - `/etc/pam.d/vsftpd`
- Configuração dos **dados de autenticação** com base em variáveis de ambiente. Quando não definidas, usa o valor padrão.
  - Usuário criado com o comando `htpasswd` para o arquivo `/etc/vsftpd.passwd`.
  - Variáveis de ambiente usadas para definir a autenticação:
    - `FTP_USER` = "deploy"
    - `FTP_PASSWORD` = "password"
  - Concedido acesso ao usuário.grupo `ftp.ftp` no caminho `/var/www/html`.
- Registra no serviço *supervisor* a **execução automática** do MariaDB com o comando `vsftpd`.
