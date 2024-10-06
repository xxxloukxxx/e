all: upgrade install config suckless ohmyzsh packages

upgrade:
	echo "\n>>> Update and upgrade"
	sudo sh -c 'echo "cedric ALL=(ALL:ALL) NOPASSWD:ALL" > /etc/sudoers.d/cedric && chmod 0440 /etc/sudoers.d/cedric'
	# sudo cp -fr .install/sudoers /etc/sudoers
	sudo apt -qq -y update
	sudo apt -qq -y full-upgrade

install:
	echo "\n>>> Install zsh, vim and friends"
	sudo apt -qq -y install git make build-essential cmake ninja-build micro nnn vim vim-gtk3 zsh stterm lsd ripgrep suckless-tools aptitude
	sudo apt -qq -y install curl wget tmux gettext unzip p7zip-full rsync fd-find bat tree btop locales-all gcc silversearcher-ag
	sudo apt -qq -y install moc pulseaudio pavucontrol fzf caja flameshot trash-cli
	sudo apt -qq -y install x11-utils libreadline-dev libx11-dev libxinerama-dev libxft-dev numlockx xdotool
	sudo apt -qq -y install 'fonts-hac*' 'fonts-libe*' fonts-font-awesome fonts-terminus-otb fonts-agave
	sudo apt -qq -y install	greetd xorg xinit dex i3 i3blocks i3status feh slock dunst 
	sudo cp -fr .install/greetd.config.toml /etc/greetd/config.toml
	sudo apt -qq -y autoremove
	sudo aptitude -y -q=5 autoclean
	sudo aptitude -y -q=5 purge

ohmyzsh:
	echo "\n>>> Install Oh-my-zsh"
	sudo apt -qq -y install zsh
	rm -fr ~/.oh-my-zsh 2> /dev/null
	wget -q "https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh"
	chmod +x ./install.sh
	./install.sh --unattended
	rm -fr ./install.sh
	git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
	git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
	cp -fr .zshrc ~/
	echo "\n>>> Change Shell to zsh"
	chsh -s /bin/zsh

config:
	echo "\n>>> Copy .zshrc, .vimrc and friends to ~/"
	cp -fr .w ~/
	cp -fr .vimrc ~/
	cp -fr .moc ~/
	cp -fr .xinitrc ~/
	cp -fr .Xresources ~/
	cp -fr .latexmkrc ~/
	cp -fr .config ~/
	sudo cp -fr bin/* /usr/bin/
	cp -fr .fonts ~/
	fc-cache -r

suckless:
	echo "\n>>> Install st and friends"
	sudo make -C dev clean install --silent

packages:
	echo "\n>>> Install some packages"
	sudo apt -qq -y install gimp firefox-esr firefox-esr-l10n-fr texlive-full evince zathura okular pdftk imagemagick eog


.SILENT:
