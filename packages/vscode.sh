if [[ $OS == "ChromeOS" ]]; then
        echo "Installing Codile"
        get https://github.com/dimkr/codile/releases/download/latest/codile_0.0.1_amd64.deb

        echo "Codile DONE"
    else
        sudo apt-get install -qq codium
        echo "VSCODIUM DONE"
fi