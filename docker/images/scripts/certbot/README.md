# Instalar certificado SSL para o Apache HTTP Server

Script para **instalação** de certificado SSL para o Apache HTTP Server. O certificado é gerado pelo Let's Encrypt.

## Dependências

O script `run.sh` depende de...

1. Uma instalação do Linux Ubuntu
2. Uma instalação do Apache HTTP Server.

## Tarefas executadas

- Preparação do **repositório do apt-get, pear and pecl** para download da versão mais recente.
- Inclui a instalação dos seguintes drivers:
  - `pdo_sqlsrv`
  - `msodbcsql17`
  - `unixodbc-dev`
  - `sqlsrv`
