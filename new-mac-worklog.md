# My steps to set up a new mac

I've done this enough lately that it seemed worthwhile to write down all the steps.

## Basic add-on apps

* Install Dropbox and sync it down
* Install 1password

## CLI Environment

* get rsa ssh key from 1password
* git clone git@github.com:ahpook/dotfiles.git
-> sync.zsh these files locally

* Install [iterm2](https://iterm2.com) ; point its preferences at ~/Dropbox
* Install FiraCode and Hack fonts
* Install [brew](https://brew.sh) ; this will prompt for xcode tools
* brew install tmux zsh rust
* cargo install dua ripgrep exa fd-find bat
-> new macOS requires adjusting path because /usr/local/ isn't writeable anymore
-> fixed in .zshrc
* add /opt/homebrew/bin/zsh to /etc/shells
* chsh to /opt/homebrew/bin/zsh
* Install zprezto. Start new shell and make sure it's all good.
  

# Audio stuff

* install elektron overbridge https://elektron.se/
* install and authorize audio hijack and loopback https://rogueamoeba.com
* install and authorize Ableton Live https://ableton.com
* install and authorize Traktor Pro https://native-instruments.com
* install audiodamage plugins: continua, filterstation, kombinat https://audiodamage.com
* install soundtower - https://www.soundtower.com/rev2/index.html
* install GFI SpecLab - https://www.gfisystem.com/download-specular-tempus
* install line 6 pod edit - https://line6.com
