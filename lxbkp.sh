#/bin/bash
# Este e um script de backup para Linux criado por
# Eduardo Hirochi Inoue - eduardoinoue@gmail.com
# Data de criacao: 28/02/2019
# Versao: 0.1

# Variaveis globais do Script
BKPCONFIGDIR=/etc/lxbkp
BKPDIR=/var/backups
BKPLOGFILE=/var/log/lxbkp.txt
VARHOSTNAME=`cat /etc/hostname`
# No arquivo abaixo coloque a cada linha o que deve ser backupeado
FILENAME="$BKPCONFIGDIR/config/lxbkplist.txt"

#Variavel para a quantidade de dias para manter no backup
TIME_BKCP=+30


backupfull(){
#Variaveis da funcao backupfull()

DATEFILENAME=`date +%Y-%m-%d_%H_%M_%S`
DATA=`date +%d/%m/%Y_%H:%M:%S`

if [ ! -d $BKPCONFIGDIR ]
then
     echo "Criando a estrutura de Backup $BKPCONFIGDIR"
     echo $(date +%d/%m/%Y_%H:%M:%S) "Criando a estrutura de Backup $BKPCONFIGDIR" >> $BKPLOGFILE
     mkdir $BKPCONFIGDIR
     mkdir $BKPCONFIGDIR/config
     sleep 3
     clear	
else
     echo "O diretorio $BKPCONFIGDIR ja existe"
     echo $(date +%d/%m/%Y_%H:%M:%S) "O diretorio $BKPCONFIGDIR ja existe" >> $BKPLOGFILE
     sleep 3
     clear
fi


while read -r line
do
    name="$line"
    echo "Name read from file - $name"
    TEMPDIRNAME=`echo $line | sed 's/[/]/_/g'`_fullbkp
    TEMPFILENAME=""$DATEFILENAME"_"$VARHOSTNAME""$TEMPDIRNAME"".tar.bz2""
    echo "Iniciando o backup do diretorio $line em $DATA"
    echo $(date +%d/%m/%Y_%H:%M:%S) "Iniciando o backup do diretorio $line no arquivo $TEMPFILENAME" >> $BKPLOGFILE
    tar -jcvjf $BKPDIR/$TEMPFILENAME $line
    echo "Calculando o hash MD5 do arquivo $TEMPFILENAME"
    md5sum $BKPDIR/$TEMPFILENAME > $BKPDIR/$TEMPFILENAME.md5
    echo $(date +%d/%m/%Y_%H:%M:%S) "Calculando o hash md5 do arquivo $TEMPFILENAME" >> $BKPLOGFILE
    md5sum $BKPDIR/$TEMPFILENAME >> $BKPLOGFILE
    echo "Fim do backup do diretorio $line em $DATA"
    echo $(date +%d/%m/%Y_%H:%M:%S) "Fim do backup do diretorio $line no arquivo $TEMPFILENAME" >> $BKPLOGFILE
    clear
done < "$FILENAME"
}

backupfullmysql(){
DATEFILENAME=`date +%Y-%m-%d_%H_%M_%S`
DATA=`date +%d/%m/%Y_%H:%M:%S`
TEMPDIRNAME=_mysql_fullbkp
TEMPMYSQLFILENAME=""$DATEFILENAME"_"$VARHOSTNAME""$TEMPDIRNAME"".tar.bz2""
MYSQLDUMP=/usr/bin/mysqldump

    echo "Iniciando o backup full do Mysql"
    echo $(date +%d/%m/%Y_%H:%M:%S) "Iniciando o backup full do Mysql" >> $BKPLOGFILE
    sleep 2
    mysqldump --defaults-file=/etc/lxbkp/config/.my.cnf --all-databases | bzip2 > $BKPDIR/$TEMPMYSQLFILENAME

    echo "Calculando o hash MD5 do arquivo $TEMPMYSQLFILENAME"
    md5sum $BKPDIR/$TEMPMYSQLFILENAME > $BKPDIR/$TEMPMYSQLFILENAME.md5
    echo $(date +%d/%m/%Y_%H:%M:%S) "Calculando o hash md5 do arquivo $TEMPMYSQLFILENAME" >> $BKPLOGFILE
    md5sum $BKPDIR/$TEMPMYSQLFILENAME >> $BKPLOGFILE
    sleep 2
    echo "Fim do backup full do Mysql"
    echo $(date +%d/%m/%Y_%H:%M:%S) "Fim do backup full do Mysql" >> $BKPLOGFILE
    sleep 2
}

retencaodebackup(){
#Esta Funcao busca na pasta de BKP da Variavel $BKPDIR por arquivos maiores que a
# Variavel $TIME_BKCP
find $BKPDIR -name "*fullbkp*" -ctime $TIME_BKCP -exec rm -f {} ";"
   if [ $? -eq 0 ] ; then
      echo "Arquivo de backup mais antigo eliminado com sucesso!"
	sleep 3
   else
      echo "Erro durante a busca e destruição do backup antigo!"
	sleep 3
   fi
}

backupfull
backupfullmysql
retencaodebackup
