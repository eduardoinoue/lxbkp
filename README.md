# lxbkp
This is a simple backup script for Linux where you can choose what to backup using a text file and also backup MYSQL Server

Para utilizar este script na configuracao padrão é necessários criar alguns diretórios
/etc/lxbkp/ = Este diretório é utilizado para salvar arquivos de configuração do script
/etc/lxbkp/config = Este diretorio é utilizado para salvar as credenciais de acesso para o MySQL

## Criando os diretórios
mkdir -p /etc/lxbkp/config
mkdir -p /var/backups

## Arquivo de Log
Todas as operações de backup são registradas no arquivo abaixo:
/var/log/lxbkp.txt

# Variavel de retenção de backup
Arquivos mais atigos do que 30 dias serão apagados do diretório /var/backups
TIME_BKCP=+30

