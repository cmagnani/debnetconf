#!/bin/bash

# Reconfiguration de l'interface eth0
# Christophe MAGNANI 2015


# Dialog avec paramètres par defaut
DIALOG='/usr/bin/dialog --backtitle DebNetConf'
DIALOG_OUINON=$DIALOG' --no-label Non --yes-label Oui'
DIALOG_SUIVPREC=$DIALOG' --cancel-label Suivant --no-label Suivant' 


# Variables globales
TEMPFILE=`TEMPFILE 2>/dev/null` || TEMPFILE=/tmp/test$$
SCREEN_SIZE='20 60'


# Fonctions
function NetConfigDHCP {
   echo  test2
   }

function NetConfigManuel {
    $DIALOG  --title 'Parametres TCPIP' --form '\n' $SCREEN_SIZE 16 \
                                    'Adresse :' 1 1 '' 1 25 25 30 \
                                    'Masque de sous-reseau :' 2 1 '' 2 25 25 30 \
                                    'Passerelle :' 3 1 '' 3 25 25 30 \
                                    'Serveur DNS1 :' 4 1 '' 4 25 25 30 \
                                    'Serveur DNS2 :' 5 1 '' 5 25 25 30 \
                                     2> $TEMPFILE    
    echo hop
   }

function NetConfigMode {
    $DIALOG --radiolist 'Mode reseau' $SCREEN_SIZE 15 1 DHCP ON 2 Manuel OFF \
        2> $TEMPFILE
    
    RETVAL=$?
    CHOIX=`cat $TEMPFILE`

    case $RETVAL in
        0) case $CHOIX in
            1) NetConfigDHCP;;
            2) NetConfigManuel;;
            esac
            ;;
        1) echo 'Sotie par annuler'
            exit;;
        255) echo 'Sortie par l utilisateur' 
             exit;;
    esac
}

function GenClefSSH {
    echo hop
}

function ChoixConfig {
    $DIALOG --checklist 'Choix configuration' $SCREEN_SIZE 15 1 'Génération des clefs SSH' OFF 2 'Configuration réseau' OFF \
        2> $TEMPFILE

    RETVAL=$?
    CHOIX=`cat $TEMPFILE`

    case $RETVAL in
        0) for ITEM in $CHOIX; do
            echo $ITEM
            if [ "$ITEM"="1" ]; then
                GenClefSSH 
            fi 
            if [ "$ITEM"="2" ]; then
                NetConfigMode
            fi
           done
            
            ;;
        1) echo 'Sortie par annuler'
            exit;;
        255) echo 'Dortie par l utilisateur'
            exit;;
    esac

}

# Main 
ChoixConfig
# NetConfigMode
echo $MODE
