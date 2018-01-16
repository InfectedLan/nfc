function install {
    python setup.py install
    cd ..
}
function pullret {
    git pull
    cd ..
}

function uppdate {
    git pull > $pullMsg
    if [ ! $pullMsg = *"Already up tp date."*]; then
        exec setup.sh
        exit
    fi; if [ ! -d "SPI-Py" ]; then
        git clone https://github.com/lthiery/SPI-Py.git
        cd SPI-Py
        install
    else
        cd SPI-Py
        git pull
        install
    fi; if [ ! -d "MFRC522-python" ]; then
        git clone https://github.com/mxgxw/MFRC522-python.git
    else
        cd MFRC522-python
        pullret
    fi;
    if [ "$HOSTNAME" = *"door"* ]; then
        $door = "nfc_door"
        if [ ! -d $door ]; then
            git clone https://github.com/InfectedLan/$door.git
        else
            cd $door
            pullret
        fi
    fi; if [ "$HOSTNAME" = *"kafe"* ]; then
        $kafe = "kafe_client_nfc"
        if [ ! -d $kafe ]; then
            git clone https://github.com/InfectedLan/$kafe.git
        else
            cd $kafe
            pullret
        fi
    fi; if [ "$HOSTNAME" = *"checkin"* ]; then
        $checkin = "nfc_checkin"
        if [ ! -d $checkin ]; then
            git clone https://github.com/InfectedLan/$checkin.git
        else
            cd $checkin
            pullret
        fi
    fi
}

function init {
    pacman -Syu
    if [ ! "$Hostname" = *"door"* ]; then
        pacman -S xorg i3
        echo "exec i3" > ~/.xinitrc
    fi
    cat ~/.profile > $prof
    $expr = "exec ~/nfc_client/setup.sh"
    if [ ! $prof = *$expr* ]; then
        echo $expr >> ~/.profile
    fi
    uppdate
    cd ~/
}
