sudo apt update
sudo apt install fonts-font-awesome
mkdir -p ~/.local/share/fonts
cd /tmp
wget -O FiraCode.zip "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.zip"
unzip FiraCode.zip -d ~/.local/share/fonts

apt install qutebrowser

sudo snap install btop
