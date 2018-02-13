function install {
    python setup.py install
    cd ..
}

function uppdate {
    cd ~/nfc_client
    git pull > pullMsg
    if [ ! $pullMsg = *"Already up tp date."* ]; then
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

function run {
    uppdate
    if [ "$HOSTNAME" = *"door"* ]; then
        python ./src/door.py
    fi; if [ "$HOSTNAME" = *"kafe"* ]; then
        python ./kafe.py
    fi; if [ "$HOSTNAME" = *"checkin"* ]; then
        python ./src/checkin.py
    fi
}

run
