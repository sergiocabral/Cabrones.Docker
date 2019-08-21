# Drivers para o Microsoft SQL Server

Script para **instalação e configuração** inicial dos drivers para o Microsoft SQL Server.

## Dependências

O script `run.sh` depende de...

1. Uma instalação do Linux Ubuntu
2. Uma instalação do Apache HTTP Server.
3. Módulo PHP instalado para o Apache HTTP Server.

## Tarefas executadas

- Preparação do **repositório do apt-get, pear and pecl** para download da versão mais recente.
- Inclui a instalação dos seguintes drivers:
  - `pdo_sqlsrv`
  - `msodbcsql17`
  - `unixodbc-dev`
  - `sqlsrv`
