# Verifica se o Zsh está instalado
if ! command -v zsh>/dev/null; then
    echo "O Zsh não está instalado. Por favor, instale o Zsh antes de continuar."
    sudo apt install zsh

    chsh -s $(which zsh)

    sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

    sudo apt install zsh-syntax-highlighting

    echo "source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc
fi

# Caminho para o arquivo.zshrc
ZSHRC_FILE="$HOME/.zshrc"

# Verifica se o arquivo.zshrc existe
if [ -f "$ZSHRC_FILE" ]; then
    echo "Atualizando.zshrc..."
    # Substitui o conteúdo do arquivo.zshrc pelas novas configurações
    cat > "$ZSHRC_FILE" << EOF
export ZSH="$HOME/.oh-my-zsh"
export PATH=$PATH:/home/guilherme/.spicetify

ZSH_THEME="robbyrussell"

plugins=(git dotnet docker docker-compose mvn npm common-aliases command-not-found debian themes zsh-autosuggestions)

alias zshrc="source \$HOME/.zshrc"
alias la="ls -a"
alias cls="clear"
alias python="python3"

qrcode () {
    local input="\$*"
    [ -z "\$input" ] && local input="@/dev/stdin"
    curl -d "\$input" https://qrcode.show
}

qrsvg () {
    local input="\$*"
    [ -z "\$input" ] && local input="@/dev/stdin"
    curl -d "\${input}" https://qrcode.show -H "Accept: image/svg+xml"
}

qrserve () {
    local port=\${1:-8080}
    local dir=\${2:-.}
    local ip="\$(ifconfig | grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | fzf --prompt IP:)" \
    && echo http://\$ip:\$port | qrcode \
    && python -m http.server \$port -b \$ip -d \$dir
}

source \$ZSH/oh-my-zsh.sh
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

theme
clear
neofetch
EOF
else
    echo "Criando.zshrc..."
    # Cria o arquivo.zshrc com as novas configurações
    cat > "$ZSHRC_FILE" << EOF
export ZSH="$HOME/.oh-my-zsh"
export PATH=$PATH:/home/guilherme/.spicetify

ZSH_THEME="robbyrussell"

plugins=(git dotnet docker docker-compose mvn npm common-aliases command-not-found debian themes zsh-autosuggestions)

alias zshrc="source \$HOME/.zshrc"
alias la="ls -a"
alias cls="clear"
alias python="python3"

qrcode () {
    local input="\$*"
    [ -z "\$input" ] && local input="@/dev/stdin"
    curl -d "\$input" https://qrcode.show
}

qrsvg () {
    local input="\$*"
    [ -z "\$input" ] && local input="@/dev/stdin"
    curl -d "\${input}" https://qrcode.show -H "Accept: image/svg+xml"
}

qrserve () {
    local port=\${1:-8080}
    local dir=\${2:-.}
    local ip="\$(ifconfig | grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | fzf --prompt IP:)" \
    && echo http://\$ip:\$port | qrcode \
    && python -m http.server \$port -b \$ip -d \$dir
}

source \$ZSH/oh-my-zsh.sh
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

theme
clear
neofetch
EOF
fi

echo "Configurações do.zshrc atualizadas com sucesso!"

sudo curl -o ./cleanupAndFirmware https://raw.githubusercontent.com/sowinghustle/setup-debian/master/cleanupAndFirmware