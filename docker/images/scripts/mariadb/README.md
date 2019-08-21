# MariaDB

Script para **instalação e configuração** inicial do MariaDB.

## Dependências

O script `run.sh` depende de...

1. Uma instalação do Linux Ubuntu.
2. Dos seguintes arquivos nesta pasta:
   - `my.cnf`
   - `authentication.sql`

## Tarefas executadas

- Preparação do **repositório do apt-get** para download da versão mais recente.
- Instalação do **MariaDB**.
- **Backup** de arquivos originais.
  - `/etc/mysql/my.cnf` para `/etc/mysql/my.cnf.original`.
- Configuração dos **dados de autenticação** com base em variáveis de ambiente. Quando não definidas, usa o valor padrão.
  - A configuração é feita com a execução do script SQL `authentication.sql` que tem seu conteúdo ajustado com base nas variáveis de ambiente.
  - Variáveis de ambiente usadas para definir a autenticação:
    - `MYSQL_ROOT_USER` = "root"
    - `MYSQL_ROOT_HOST` = "%"
    - `MYSQL_ROOT_PASSWORD` = "password"
- Escrita do **arquivo de configuração** `/etc/mysql/my.cnf` com base no arquivo de mesmo nome nesta pasta.
- Registra no serviço *supervisor* a **execução automática** do MariaDB com o comando `mysqld_safe`.
