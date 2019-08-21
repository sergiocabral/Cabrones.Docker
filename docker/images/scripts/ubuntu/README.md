# Linux Ubuntu

Script para configuração inicial do **Linux Ubuntu** após primeira instalação.

## Dependências

O script `run.sh` depende de...

1. Uma instalação do Linux Ubuntu.

## Tarefas executadas

- Definição do **timezone**.
- **Atualização do apt-get** com `update`, `upgrade` e `autoremove`.
- Instalação de **pacotes úteis**:
  - Editor de textos `vim`.
  - Ferramenta de rede `ping`.
  - Serviço de execução em background `supervisor`.
- Configuração inicial do serviço **supervisor**.
