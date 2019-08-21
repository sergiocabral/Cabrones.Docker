# Apache HTTP Server

Script para **instalação e configuração** inicial do Apache HTTP Server.

## Dependências

O script `run.sh` depende de...

1. Uma instalação do Linux Ubuntu.
2. Dos seguintes arquivos nesta pasta:
   - `apache.conf`

## Tarefas executadas

- Instalação do **Apache HTTP Server**.
- **Backup** de arquivos originais.
  - `/etc/apache2/apache2.conf` para `/etc/apache2/apache2.conf.original`.
- Ativação dos **módulos** do Apache HTTP Server:
  - `rewrite`
  - `ssl`
- Escrita do **arquivo de configuração** `/etc/apache2/apache2.conf` com base no arquivo de mesmo nome nesta pasta.
- **Remoção dos websites** criados por padrão na instalação do Apache HTTP Server.
- Criação do **website padrão**.
  - O nome do domínio e e-mail do webmaster são definidos pelas variáveis de ambiente. Quando não definidas são usados seus valores padrão:
    - `HTTP_DOMAIN` = "localhost"
    - `HTTP_EMAIL` = "webmaster@localhost"
- Registra no serviço *supervisor* a **execução automática** do Apache HTTP Server com o comando `apache2ctl -D FOREGROUND`.
