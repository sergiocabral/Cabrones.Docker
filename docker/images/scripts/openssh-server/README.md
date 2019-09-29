# SSH Server

Script para **instalação e configuração** inicial do Open SSH Server.

## Dependências

O script `run.sh` depende de...

1. Uma instalação do Linux Ubuntu.
2. Dos seguintes arquivos nesta pasta:
   - `ssh_config`
   - `sshd_config`

## Tarefas executadas

- Instalação do **Open SSH Server**.
- **Backup** de arquivos originais.
  - `/etc/ssh/ssh_config` para `/etc/ssh/ssh_config.original`.
  - `/etc/ssh/sshd_config` para `/etc/ssh/sshd_config.original`.
- Escrita dos **arquivos de configuração** `abaixo com base no arquivo de mesmo nome nesta pasta:
  - `/etc/ssh/ssh_config`
  - `/etc/ssh/sshd_config`
- Criação do **usuário de autenticação** com base em variáveis de ambiente. Quando não definidas, usa o valor padrão.
  - Usuário de sistema criado com o comando `adduser`.
  - Definido senha do usuário com o comando `chpasswd`.
  - Variáveis de ambiente usadas para definir a autenticação:
    - `SSH_USER` = "sshuser"
    - `SSH_PASSWORD` = "password"
  - Concedido acesso ao usuário.grupo `sudo` para execuçaõ de comandos como administrador.
  - Ajustado mensagem de boas-vindas motd.
- Registra no serviço *supervisor* a **execução automática** do MariaDB com o comando `openssh`.
