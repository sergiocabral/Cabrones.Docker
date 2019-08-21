# PHP

Script para **instalação e configuração** inicial do PHP.

## Dependências

O script `run.sh` depende de...

1. Uma instalação do Linux Ubuntu.
2. Uma instalação do Apache HTTP Server.
3. Dos seguintes arquivos nesta pasta:
   - `php.ini`

## Tarefas executadas

- Preparação do **repositório do apt-get** para download da versão mais recente.
- Instalação do **PHP e módulos**:
  - `php`
  - `php_xdebug`
  - `php_mbstring`
  - `php-zip`
  - `php-mysql`
  - `php-xml`
  - `php-pear`
  - `php-dev`
- **Backup** de arquivos todos os originais. O asterísco representa o número da versão do PHP.
  - `/etc/php/*/apache2/php.ini` para `/etc/php/*/apache2/php.ini.original`.
- Escrita do **arquivo de configuração** `/etc/php/*/apache2/php.ini` com base no arquivo de mesmo nome nesta pasta.
