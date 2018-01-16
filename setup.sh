function install {
    python setup.py install
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
        git pull
        cd ..
    fi;
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
}

function run {
    init
    if [ "$HOSTNAME" = *"door"* ]; then
        ~/nfc_client/src/door.py
    fi; if [ "$HOSTNAME" = *"kafe"* ]; then
        ~/nfc_client/src/kafe.py
    fi; if [ "$HOSTNAME" = *"checkin"* ]; then
        ~/nfc_client/src/checkin.py
    fi
}
