#!/bin/bash

mkdir /home/ubuntu/log_server

startOdooSever() {
    export DEBIAN_FRONTEND=noninteractive
    echo -e "Iniciando servidor odoo" >> /home/ubuntu/log_server/init_log

    echo -e "Criando pasta de projeto" >> /home/ubuntu/log_server/init_log
    mkdir /home/ubuntu/projects

    echo -e "Atualizando Sistema pacotes..." >> /home/ubuntu/log_server/init_log
    sudo apt update

    echo -e "Atualziando Pacotes" >> >> /home/ubuntu/log_server/init_log
    sudo apt upgrade -yq

    echo -e "Instalando dependências de software" >> /home/ubuntu/log_server/init_log
    sudo apt install docker.io docker-compose git -yq

    echo -e "Clonando projeto" >> /home/ubuntu/log_server/init_log
    sudo chmod 777 /home/ubuntu/projects
    cd /home/ubuntu/projects 
    git clone --recurse-submodules https://DanielNery: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@github.com/erp-odoo-brasil/jmenegassi-erp.git --branch=master
    sudo chmod -R 777 /home/ubuntu/projects/jmenegassi-erp

    echo -e "Preparando módulos de terceiro" >> /home/ubuntu/log_server/init_log
    cd /home/ubuntu/projects/jmenegassi-erp/addons/thirdparty-addons
    git checkout master
    git submodule update --init --recursive

    echo -e "Preparando variáveis de ambiente" >> /home/ubuntu/log_server/init_log
    echo -e "GOOGLE_MAPS_API_TOKEN=AIzaSyAz_YuYMsM7aExWVV4eGdwag4BYIXzZWZY" >> /home/ubuntu/projects/jmenegassi-erp/.env

    echo -e "Baixando imagens e subindo containers" >> /home/ubuntu/log_server/init_log
    sudo docker-compose up --detach --build

    echo -e "Autorizando filestore" >> /home/ubuntu/log_server/init_log
    sudo chmod -R 777 ./odoo-web-data/filestore/jmenegassi

    echo -e "Subindo Projeto" >> /home/ubuntu/log_server/init_log
    sudo docker-compose stop odoo 
    sudo docker-compose run --rm odoo odoo -c /etc/odoo/odoo.conf -i base --stop-after-init
    sudo docker-compose restart
}

startOdooSever
echo -e "Processo de inicialização do projeto realizado com sucesso." >> /home/ubuntu/log_server/init_log