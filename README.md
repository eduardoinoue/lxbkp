## lxbkp
This is a simple backup script for Linux where you can choose what to backup using a text file and also backup MYSQL Server

## Para os iniciantes
Para usar este script é necessário dar permissão de execução
chmox +x lxbkp.sh

Para executar o script
./lxbkp.sh

## Criando os diretórios necessários
Para utilizar este script na configuracao padrão é necessários criar alguns diretórios
/etc/lxbkp/ = Este diretório é utilizado para salvar arquivos de configuração do script
/etc/lxbkp/config = Este diretorio é utilizado para salvar as credenciais de acesso para o MySQL

## Criando os diretórios
mkdir -p /etc/lxbkp/config
mkdir -p /var/backups

## Arquivo de Log
Todas as operações de backup são registradas no arquivo abaixo:
/var/log/lxbkp.txt

## Variavel de retenção de backup
Arquivos mais atigos do que 30 dias serão apagados do diretório /var/backups
TIME_BKCP=+30

## Credenciais de acesso ao MYSQL
Crie um arquivo em /etc/lxbkp/config/.my.cnf
com o seguinte formato

[mysqldump]
user=Nome-do-Usuario
password=Senha-do-usuarios

OBS: Protegendo o arquivo
chmod 600 /etc/lxbkp/config/.my.cnf && sudo chown $USER:nogroup /etc/lxbkp/config/.my.cnf

## Para Facilitar a sua vida para clonar este repositorio use o comando abaixo
git clone git://github.com/eduardoinoue/lxbkp
