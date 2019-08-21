# Imagens para Docker

Lista de builds para imagens disponíveis para Docker
- `ubuntu.dockerfile`: Linux Ubuntu. Deve ser o primeiro script executado para preparar o ambiente. Isso porque todos os scripts foram escritos para rodar no Linux Ubuntu.
- `ubuntu+mysql.dockerfile`: Linux Ubuntu com serviço de banco de dados MySQL.
  - Banco de dados MySQL servidor pelo MariaDB.
- `ubuntu+http+ftp.dockerfile`: Linux Ubuntu com serviço HTTP e FTP para publicação dos arquivos.
  - HTTP servido pelo apache2.
  - Suporte para PHP 7.3 com driver pdo_sqlsrv.
  - FTP servido pelo vsftpd com acesso a pasta do website.

> No desenvolimento dos arquivos `.dockerfile` foi preferido usar duplicação de texto nos comandos `RUN` a usar variáveis com `ARG`. O motivo é que quando se usava variáveis no dockerfile, as imagens geradas com o build não eram reaproveitadas em outros builds.

Nas pasta `scripts` estão a lista de aplicações e serviços que são configurados pelo arquivo `script.sh`.

O arquivo pode ser executado manualmente ou através do *Dockerfile*. Como premissa, devem ser executados em Linux Ubuntu.

