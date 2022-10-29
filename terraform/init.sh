#!/bin/bash
echo "Iniciando servidor Odoo"
echo "Criando arquivo de logs de inicialização"
mkdir /home/ubuntu/log_server
echo -e "Iniciando servidor odoo" >> /home/ubuntu/log_server/init_log
echo "Criando pasta de projeto"
echo -e "Criando pasta de projeto" >> /home/ubuntu/log_server/init_log
mkdir /home/ubuntu/projects
echo "Atualizando Sistema Operacional..."
echo -e "Atualizando Sistema Operacional..." >> /home/ubuntu/log_server/init_log
sudo apt update && sudo apt upgrade -y
echo "Instalando dependências de software"
echo -e "Instalando dependências de software" >> /home/ubuntu/log_server/init_log
sudo apt install git docker docker-compose -y
echo "Clonando projeto"
echo -e "Clonando projeto" >> /home/ubuntu/log_server/init_log
cd /home/ubuntu/projects && git config --global user.name "DanielNery" && git config user.email "danielpontesnery@gmail.com" && git clone --recurse-submodules --remote-submodules https://github.com/erp-odoo-brasil/jmenegassi-erp.git --branch=master
echo "Subindo projeto"
echo -e "Subindo Projeto" >> /home/ubuntu/log_server/init_log
sudo docker-compose stop odoo && \
    sudo docker-compose run --rm odoo odoo -c /etc/odoo/odoo.conf -i base --stop-after-init && \
    sudo docker-compose restart
echo "Processo de inicialização do projeto realizado com sucesso."
echo -e "Processo de inicialização do projeto realizado com sucesso." >> /home/ubuntu/log_server/init_log