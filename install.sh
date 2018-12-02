clear
echo "
██╗███╗   ██╗███████╗████████╗ █████╗ ██╗     ██╗     ███████╗██████╗
██║████╗  ██║██╔════╝╚══██╔══╝██╔══██╗██║     ██║     ██╔════╝██╔══██╗
██║██╔██╗ ██║███████╗   ██║   ███████║██║     ██║     █████╗  ██████╔╝
██║██║╚██╗██║╚════██║   ██║   ██╔══██║██║     ██║     ██╔══╝  ██╔══██╗
██║██║ ╚████║███████║   ██║   ██║  ██║███████╗███████╗███████╗██║  ██║
╚═╝╚═╝  ╚═══╝╚══════╝   ╚═╝   ╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝╚═╝  ╚═╝
";
if [ "$PREFIX" = "/data/data/com.termux/files/usr" ]; then
    INSTALL_DIR="$PREFIX/usr/share/doc/SecurityXploit"
    BIN_DIR="$PREFIX/bin/"
    BASH_PATH="$PREFIX/bin/bash"
    TERMUX=true

    pkg install -y git python2
elif [ "$(uname)" = "Darwin" ]; then
    INSTALL_DIR="/usr/local/SecurityXploit"
    BIN_DIR="/usr/local/bin/"
    BASH_PATH="/bin/bash"
    TERMUX=false
else
    INSTALL_DIR="$HOME/.SecurityXploit"
    BIN_DIR="/usr/local/bin/"
    BASH_PATH="/bin/bash"
    TERMUX=false

    sudo apt-get install -y git python2.7
fi

echo "[✔] Checking directories...";
if [ -d "$INSTALL_DIR" ]; then
    echo "[◉] A directory SecurityXploit was found! Do you want to replace it? [Y/n]:" ;
    read mama
    if [ "$mama" = "y" ]; then
        if [ "$TERMUX" = true ]; then
            rm -rf "$INSTALL_DIR"
            rm "$BIN_DIR/SecurityXploit*"
        else
            sudo rm -rf "$INSTALL_DIR"
            sudo rm "$BIN_DIR/SecurityXploit*"
        fi
    else
        echo "[✘] If you want to install you must remove previous installations [✘] ";
        echo "[✘] Installation failed! [✘] ";
        exit
    fi
fi
echo "[✔] Cleaning up old directories...";
if [ -d "$ETC_DIR/Phhitachi" ]; then
    echo "$DIR_FOUND_TEXT"
    if [ "$TERMUX" = true ]; then
        rm -rf "$ETC_DIR/Phhitachi"
    else
        sudo rm -rf "$ETC_DIR/Phhitachi"
    fi
fi

echo "[✔] Installing ...";
echo "";
git clone --depth=1 https://github.com/PhHitachi/SecurityXploit "$INSTALL_DIR";
echo "#!$BASH_PATH
python $INSTALL_DIR/Xploit.pl" '${1+"$@"}' > "$INSTALL_DIR/SecurityXploit";
chmod +x "$INSTALL_DIR/SecurityXploit";
if [ "$TERMUX" = true ]; then
    cp "$INSTALL_DIR/SecurityXploit" "$BIN_DIR"
    cp "$INSTALL_DIR/Xploit.cfg" "$BIN_DIR"
else
    sudo cp "$INSTALL_DIR/SecurityXploit" "$BIN_DIR"
    sudo cp "$INSTALL_DIR/Xploit.cfg" "$BIN_DIR"
fi
rm "$INSTALL_DIR/SecurityXploit";


if [ -d "$INSTALL_DIR" ] ;
then
    echo "";
    echo "[✔] Tool installed successfully! [✔]";
    echo "";
else
    echo "[✘] Installation failed! [✘] ";
    exit
fi

