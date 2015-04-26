#!/bin/bash

# Reconfiguration de l'interface eth0
# Christophe MAGNANI 2015


# Dialog avec paramètres par defaut
DIALOG='/usr/bin/dialog'
DIALOG_OUINON=$DIALOG' --no-label Non --yes-label Oui'
DIALOG_SUIVPREC=$DIALOG' --cancel-label Suivant --no-label Suivant' 


# Variables globales
TEMPFILE=`TEMPFILE 2>/dev/null` || TEMPFILE=/tmp/test$$
SCREEN_SIZE='20 60'


# Fonctions
function ConfigDHCP {
   echo  test2
   }

function ConfigManuel {
    echo hop
   }

function ConfigMode {
    $DIALOG --radiolist 'Mode reseau' $SCREEN_SIZE 15 1 DHCP ON 2 Manuel OFF \
        2> $TEMPFILE
    
    RETVAL=$?
    CHOIX=`cat $TEMPFILE`


    case $RETVAL in
        0) case $CHOIX in
            1) MODE='DHCP';;
            2) MODE='MANUEL';;
            esac
            ;;
        1) echo 'Sotie par annuler'
            exit;;
        255) echo 'Sortie par l utilisateur' 
             exit;;
    esac
}


ConfigMode
echo $MODE
