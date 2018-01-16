function clone {
    if [ ! -d "SPI-Py" ]; then
        git clone https://github.com/lthiery/SPI-Py.git
        cd SPI-Py
        python setup.py setup
        cd ..
    fi; if [ ! -d "MFRC522-python" ]; then
        git clone https://github.com/mxgxw/MFRC522-python.git
    fi;
    if [ "$HOSTNAME" = *"door"* ]; then
        if [ ! -d "nfc_door" ]; then
            git clone https://github.com/InfectedLan/nfc_door.git
        fi
    fi; if [ "$HOSTNAME" = *"kafe"* ]; then
        if [ ! -d "kafe_client_nfc" ]; then
            git clone https://github.com/InfectedLan/kafe_client_nfc.git
        fi
    fi; if [ "$HOSTNAME" = *"checkin"* ]; then
        if [ ! -d "nfc_checkin" ]; then
            git clone https://github.com/InfectedLan/nfc_checkin.git
        fi
    fi
}

function init {
    clone
    cd ~/
}
