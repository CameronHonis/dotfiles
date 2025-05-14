# precursors
apt install curl -y

# download keyrings
if [ ! -e "/etc/apt/sources.list.d/google-chrome.list" ]; then
	curl -fsSL https://dl.google.com/linux/linux_signing_key.pub | gpg --dearmor -o /usr/share/keyrings/google-chrome.gpg echo "deb [arch=amd64 
	signed-by=/usr/share/keyrings/google-chrome.gpg] http://dl.google.com/linux/chrome/deb/ stable main" | tee /etc/apt/sources.list.d/google-chrome.list
fi

apt update

# apt installs
apt install google-chrome-stable -y

# manual download prebuilts
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage
chmod u+x nvim-linux-x86_64.appimage
mkdir -p /opt/nvim
mv nvim-linux-x86_64.appimage /opt/nvim/nvim
