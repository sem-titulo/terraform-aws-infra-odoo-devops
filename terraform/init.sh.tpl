#!/bin/bash

##############################################################
#  Script     : init.sh
#  Author     : Daniel Nery <danielpontesnery@gmail.com>
#  Date       : 2023-05-25
#  Last Edited: 2023-09-25, Daniel Nery
#  Description: Script que prepara a ec2 para subir o odoo automaticamente
##############################################################

mkdir /home/ubuntu/log_server
export DEBIAN_FRONTEND=noninteractive

startOdooSever() {
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
    git clone --recurse-submodules https://${GIT_USER}:${GIT_TOKEN}@${GIT_REPOSITORY_URL} --branch=@${GIT_REPOSITORY_BRANCH}
    sudo chmod -R 777 /home/ubuntu/projects/${PROJECT_NAME}

    echo -e "Preparando módulos de terceiro" >> /home/ubuntu/log_server/init_log
    cd /home/ubuntu/projects/${PROJECT_NAME}/addons/thirdparty-addons
    git checkout master
    git submodule update --init --recursive

    echo -e "Baixando imagens e subindo containers" >> /home/ubuntu/log_server/init_log
    sudo docker-compose up --detach --build

    echo -e "Autorizando filestore" >> /home/ubuntu/log_server/init_log
    sudo chmod -R 777 ./odoo-web-data/filestore/${PROJECT_NAME}

    echo -e "Subindo Projeto" >> /home/ubuntu/log_server/init_log
    sudo docker-compose stop odoo 
    sudo docker-compose run --rm odoo odoo -c /etc/odoo/odoo.conf -i base --stop-after-init
    sudo docker-compose restart
}

startOdooSever
echo -e "Processo de inicialização do projeto realizado com sucesso." >> /home/ubuntu/log_server/init_log