# ===========================
# 🚀 .zshrc - Biglex J Edition (Debian/WSL)
# ===========================

# Configuración de Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"

# Corrección automática
ENABLE_CORRECTION="true"

# Tema vacío (personalizado)
ZSH_THEME=""

setopt prompt_subst
# Funciones personalizadas
function dir_icon {
    if [[ "$PWD" == "$HOME" ]]; then
        # Home
        echo "%{%B%F{white}%}%{%f%b%}"
    else
        # Carpeta
        echo "%{%B%F{cyan}%}%{%f%b%}"
    fi
}


function parse_git_branch {
	local branch
	branch=$(git symbolic-ref --short HEAD 2> /dev/null)
	if [ -n "$branch" ]; then
		echo " [$branch]"
	fi
}

# Habilitar vcs_info para mostrar rama de git
autoload -U add-zsh-hook
load-vcs-info() {
    zstyle ':vcs_info:*' enable git
    zstyle ':vcs_info:git*' formats ' [%b]'
    zstyle ':vcs_info:git*' actionformats ' [%b|%a]'
    zstyle ':vcs_info:git*' check-for-changes true
}
add-zsh-hook precmd load-vcs-info

# PROMPT personalizado (corregido)
PROMPT='%f %F{#45a5ff}%B%n%f%b $(dir_icon) %F{white}%B%1~%f%${vcs_info_msg_0_} %F{yellow}$(parse_git_branch)%f %(?.%B%F{#25d594}» .%F{red}»)%f%b'

# Add zsh-completions to fpath
fpath=(${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src $fpath)

# Plugins
plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-completions
    sudo
    extract
    web-search
)
source $ZSH/oh-my-zsh.sh

# Colores de resaltado de sintaxis
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=#FF4C70,bold'     # Color general
ZSH_HIGHLIGHT_STYLES[bad-command]='fg=red,bold'
ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=#00AAFF,bold'
ZSH_HIGHLIGHT_STYLES[command]=fg=#00F5CE,bold
ZSH_HIGHLIGHT_STYLES[alias]=fg=#00F5CE,bold
ZSH_HIGHLIGHT_STYLES[builtin]=fg=#00F5CE,bold

# Deshabilitar colores en ls
unset LS_COLORS
export LS_COLORS=""

# Alias de sistema
alias install='sudo apt install'
alias uninstall='sudo apt remove'
alias update='sudo apt update'
alias upgrade='sudo apt upgrade -y'
alias updateup='sudo apt update && sudo apt upgrade -y'
alias clean='sudo apt autoremove && sudo apt autoclean'

alias ..='cd ..'
alias ls='lsd'
alias ll='lsd -lh'
alias la='lsd -A'
alias lsa='lsd -lah'
alias lss='lsd -lh'
alias gc="git clone"
alias v="nvim"
alias zshconf="$EDITOR ~/.zshrc && source ~/.zshrc"

# ===========================
# 🔗 Aliases de navegación rápida (Biglex J)
# ===========================
export BASE_DRIVE="/mnt/d"

alias ...="cd ../.."
alias ....="cd ../../.."

alias bj="cd $BASE_DRIVE"
alias bjpro="cd $BASE_DRIVE/Proyectos"
alias bjpros="cd $BASE_DRIVE/Proyectos/biglexj"
alias bjdes="cd $BASE_DRIVE/Descargas"
alias bjdoc="cd $BASE_DRIVE/Documentos"
alias bjimg="cd $BASE_DRIVE/Imágenes"
alias bjmus="cd $BASE_DRIVE/Música"
alias bjvid="cd $BASE_DRIVE/Videos"
alias bjass="cd $BASE_DRIVE/Assets"
alias bjdav="cd $BASE_DRIVE/Videos/DaVinci\ Resolve"
alias bjyt="cd $BASE_DRIVE/Imágenes/YouTube"
alias bjmarca="cd $BASE_DRIVE/Imágenes/Proyectos/Marca"
alias docs="cd $BASE_DRIVE/Proyectos/biglexj/Docs"
alias aurora="cd $BASE_DRIVE/Proyectos/biglexj/Aurora---Blog"

# ===========================
# 🎨 Banner ASCII de bienvenida
# ===========================
function print_banner() {
    local banner=(
"╔═════════════════════════════════════════════════════════════════╗"
"║                                                                 ║"
"║      ██████╗ ██╗ ██████╗ ██╗     ███████╗██╗  ██╗      ██╗      ║"
"║      ██╔══██╗██║██╔════╝ ██║     ██╔════╝╚██╗██╔╝      ██║      ║"
"║      ██████╔╝██║██║  ███╗██║     █████╗   ╚███╔╝       ██║      ║"
"║      ██╔══██╗██║██║   ██║██║     ██╔══╝   ██╔██╗       ██║      ║"
"║      ██████╔╝██║╚██████╔╝███████╗███████╗██╔╝ ██╗   ██╗██║      ║"
"║      ╚═════╝ ╚═╝ ╚═════╝ ╚══════╝╚══════╝╚═╝  ╚═╝   ╚═╝╚═╝      ║"
"║                                                                 ║"
"║              W E L C O M E   T O   B I G L E X - J              ║"
"║                                                                 ║"
"║           WSL/Debian Edition • Build: CREATOR-EDITION           ║"
"║                                                                 ║"
"║   🎨 Content Creator | 💻 Developer | 🎵 JPop Enthusiast        ║"
"║   🚀 C# • React • Python | 🎬 DaVinci • Blender • OBS           ║"
"║                                                                 ║"
"║              > Ready to create amazing content...               ║"
"║                                                                 ║"
"╚═════════════════════════════════════════════════════════════════╝"
    )

    local colors=('\e[36m' '\e[35m' '\e[33m' '\e[32m' '\e[34m' '\e[31m')
    local primary_color="${colors[$((RANDOM % ${#colors[@]} + 1))]}"
    
    for line in "${banner[@]}"; do
        echo -e "${primary_color}${line}\e[0m"
    done
}

# ===========================
# ℹ️ Info del sistema
# ===========================
function show_system_info_table() {
    local os=$(lsb_release -ds 2>/dev/null || echo "Debian/WSL")
    local host_name=$(hostname)
    local user_name=$(whoami)
    local up_time=$(uptime -p 2>/dev/null | sed 's/up //' || uptime | awk '{print $3}' | tr -d ',')
    local current_date=$(date '+%d/%m/%Y %H:%M')
    local shell_ver="v$ZSH_VERSION"

    local colors=('\e[32m' '\e[33m' '\e[35m' '\e[34m' '\e[36m' '\e[31m')
    local border_color="${colors[1]}"
    local reset='\e[0m'
    
    echo -e "${border_color}┌─────────────────────────────────────────────────────────────────┐${reset}"
    
    local labels=(" S.O" " Equipo" " Usuario" " Uptime" " Fecha" " ZSH")
    local values=("$os" "$host_name" "$user_name" "$up_time" "$current_date" "$shell_ver")
    
    for i in {1..6}; do
        local color="${colors[$(((i-1) % ${#colors[@]} + 1))]}"
        printf "${border_color}│${reset}${color}%-18s${reset} | ${color}%-42s${reset}  ${border_color}│${reset}\n" "${labels[$i]}" "${values[$i]}"
    done

    echo -e "${border_color}└─────────────────────────────────────────────────────────────────┘${reset}"
}

clear
print_banner
show_system_info_table

# ===========================
# 🛠️ Utilidades de desarrollo
# ===========================
function touch_file() {
    if [[ ! -e "$1" ]]; then
        command touch "$1"
        echo -e "\e[32m✅ Archivo creado: $1\e[0m"
    else
        command touch "$1"
        echo -e "\e[33m🔄 Archivo actualizado: $1\e[0m"
    fi
}
alias touch="touch_file"

function gs() { 
    git status
    echo -e "\e[36m📊 Estado del repositorio mostrado\e[0m"
}

function ga() { 
    git add "${1:-.}"
    echo -e "\e[32m➕ Archivos agregados al staging\e[0m"
}

function gcm() { 
    if [[ -n "$1" ]]; then
        git commit -m "$1"
        echo -e "\e[32m💾 Commit realizado: $1\e[0m"
    else
        echo -e "\e[31m❌ Necesitas un mensaje de commit\e[0m"
    fi
}

function gp() { 
    git push
    echo -e "\e[32m🚀 Cambios enviados al repositorio remoto\e[0m"
}

function gpl() { 
    git pull
    echo -e "\e[34m⬇️  Cambios descargados del repositorio remoto\e[0m"
}

alias gd='git diff'
alias gb='git branch'
alias gco='git checkout'

# ===========================
# 🚀 Node/NPM/PNPM
# ===========================
alias dev='pnpm run dev'
alias build='pnpm run build'
alias start='pnpm start'
alias pni='pnpm install'
alias pnr='pnpm run'

# ===========================
# 🤖 Ely Intelligence & Live Stream
# ===========================
alias ely-intelligence="pwsh $BASE_DRIVE/Proyectos/biglexj/Aurora---Blog/scripts/start_ely_core.ps1"
alias live="pwsh $BASE_DRIVE/Proyectos/biglexj/Aurora---Blog/scripts/start_live.ps1"
alias vozely="pwsh $BASE_DRIVE/Proyectos/biglexj/Aurora---Blog/scripts/start_voz_ely.ps1"
alias voice-ely="pwsh $BASE_DRIVE/Proyectos/biglexj/Aurora---Blog/scripts/start_ely_voice_pipeline.ps1"

function add-video() {
    pwsh "$BASE_DRIVE/Proyectos/biglexj/Aurora---Blog/scripts/add-video.ps1" -Url "$1" -Type "video" -Title "$2" -Description "$3"
}

function add-karaoke() {
    pwsh "$BASE_DRIVE/Proyectos/biglexj/Aurora---Blog/scripts/add-video.ps1" -Url "$1" -Type "karaoke" -Title "$2" -Description "$3" -Tags "$4"
}

# ===========================
# 🎬 PRODUCCIÓN DE CONTENIDO
# ===========================
function new-project() {
    echo -e "\e[36m\n╔════════════════════════════════════════════════════════════════╗\e[0m"
    echo -e "\e[36m║           🎬 CREAR NUEVO PROYECTO DE VIDEO                     ║\e[0m"
    echo -e "\e[36m╚════════════════════════════════════════════════════════════════╝\n\e[0m"
    
    echo -e "\e[33m📺 Selecciona el canal:\e[0m"
    echo -e "\e[90m  1) @biglexj\e[0m"
    echo -e "\e[90m  2) @ely-vtuber\e[0m"
    echo -e "\e[90m  3) @biglexjtema\e[0m"
    echo -e "\e[90m  4) @biglexlive\e[0m"
    echo -e "\e[90m  5) @biglexpe\e[0m"
    
    read "canalOption?Opción: "
    
    local canal=""
    case $canalOption in
        1) canal="@biglexj" ;;
        2) canal="@ely-vtuber" ;;
        3) canal="@biglexjtema" ;;
        4) canal="@biglexlive" ;;
        5) canal="@biglexpe" ;;
        *) echo -e "\e[31m❌ Opción inválida\e[0m"; return 1 ;;
    esac
    
    echo -e "\e[33m\n🎥 Tipo de video:\e[0m"
    echo -e "\e[90m  1) Video normal\e[0m"
    echo -e "\e[90m  2) Short\e[0m"
    
    read "tipoOption?Opción: "
    
    local path_base="$BASE_DRIVE/Videos/DaVinci Resolve/$canal"
    
    if [[ "$tipoOption" == "2" ]]; then
        path_base="$path_base/Shorts"
    fi
    
    if [[ ! -d "$path_base" ]]; then
        echo -e "\e[31m❌ La carpeta del canal no existe: $path_base\e[0m"
        return 1
    fi
    
    local lastNumber=0
    for dir in "$path_base"/[0-9]*.(/); do
        if [[ -d "$dir" ]]; then
            local num=$(basename "$dir" | grep -Eo '^[0-9]+')
            if [[ -n "$num" ]] && (( num > lastNumber )); then
                lastNumber=$num
            fi
        fi
    done
    
    local newNumber=$((lastNumber + 1))
    echo -e "\e[32m\n📝 Número asignado: $newNumber\e[0m"
    
    read "titulo?📌 Título del video: "
    
    if [[ -z "$titulo" ]]; then
        echo -e "\e[31m❌ El título no puede estar vacío\e[0m"
        return 1
    fi
    
    local projectPath="$path_base/$newNumber. $titulo"
    
    if mkdir -p "$projectPath/Imágenes" "$projectPath/Videos" "$projectPath/Audio"; then
        echo -e "\e[32m\n✅ ¡Proyecto creado exitosamente!\e[0m"
        echo -e "\e[36m📁 Ruta: $projectPath\e[0m"
    else
        echo -e "\e[31m\n❌ Error al crear el proyecto.\e[0m"
    fi
}

# ===========================
# 🎨 UTILIDADES CREATIVAS
# ===========================
function color-palette() {
    echo -e "\n\e[36m╔════════════════════════════════════════════════════════════════╗\e[0m"
    echo -e "\e[36m║              🎨 PALETA OFICIAL BIGLEX J                        ║\e[0m"
    echo -e "\e[36m╚════════════════════════════════════════════════════════════════╝\n\e[0m"
    echo -e "\e[90m┌────────────┬────────────┬────────────┬────────────┐\e[0m"
    echo -e "\e[90m│  \e[0m\e[36m████████\e[0m\e[90m  │  \e[0m\e[31m████████\e[0m\e[90m  │  \e[0m\e[32m████████\e[0m\e[90m  │  \e[0m\e[34m████████\e[0m\e[90m  │\e[0m"
    echo -e "\e[90m│  \e[0m#00AAFF   \e[90m│  \e[0m#FF6B4C   \e[90m│  \e[0m#4CFF5B   \e[90m│  \e[0m#5B4CFF   \e[90m│\e[0m"
    echo -e "\e[90m│  \e[90mCyan Base \e[90m│  \e[90mCoral     \e[90m│  \e[90mVerde     \e[90m│  \e[90mMorado    \e[90m│\e[0m"
    echo -e "\e[90m└────────────┴────────────┴────────────┴────────────┘\e[0m"
    
    echo -e "\n\e[35m╔════════════════════════════════════════════════════════════════╗\e[0m"
    echo -e "\e[35m║             🎨 PALETA OFICIAL ELY VTUBER                       ║\e[0m"
    echo -e "\e[35m╚════════════════════════════════════════════════════════════════╝\n\e[0m"
    echo -e "\e[90m┌────────────┬────────────┬────────────┬────────────┐\e[0m"
    echo -e "\e[90m│  \e[0m\e[36m████████\e[0m\e[90m  │  \e[0m\e[35m████████\e[0m\e[90m  │  \e[0m\e[90m████████\e[0m\e[90m  │  \e[0m\e[33m████████\e[0m\e[90m  │\e[0m"
    echo -e "\e[90m│  \e[0m#00C7B1   \e[90m│  \e[0m#FB7793   \e[90m│  \e[0m#6E7179   \e[90m│  \e[0m#FFE6CA   \e[90m│\e[0m"
    echo -e "\e[90m│  \e[90mTurquesa  \e[90m│  \e[90mRosa      \e[90m│  \e[90mGris Polo \e[90m│  \e[90mBeige     \e[90m│\e[0m"
    echo -e "\e[90m└────────────┴────────────┴────────────┴────────────┘\e[0m"
}

function bgm() {
    local bgmPath="$BASE_DRIVE/Música/IA Sounds/Instrumental 2"
    if [[ -d "$bgmPath" ]]; then
        xdg-open "$bgmPath" &>/dev/null || open "$bgmPath" &>/dev/null
        echo -e "\e[36m🎵 Biblioteca de música de fondo abierta\e[0m"
    else
        echo -e "\e[31m❌ No se encontró la carpeta de música de fondo\e[0m"
    fi
}

# ===========================
# 🌐 WEB & REDES
# ===========================
function open-biglexj() {
    xdg-open "https://biglexj.com" &>/dev/null
    echo -e "\e[36m🌐 Abriendo biglexj.com...\e[0m"
}

function open-youtube() {
    xdg-open "https://studio.youtube.com" &>/dev/null
    echo -e "\e[31m📺 Abriendo YouTube Studio...\e[0m"
}

# ===========================
# ⚙️ SISTEMA Y MANTENIMIENTO
# ===========================
function check-space() {
    echo -e "\n\e[33m╔════════════════════════════════════════════════════════════════╗\e[0m"
    echo -e "\e[33m║              💾 ESPACIO EN DISCOS                              ║\e[0m"
    echo -e "\e[33m╚════════════════════════════════════════════════════════════════╝\n\e[0m"
    df -h | grep -v 'loop'
}

function update-profile() {
    source ~/.zshrc
    echo -e "\e[32m✅ Configuración de ZSH recargada\e[0m"
}

function edit-profile() {
    $EDITOR ~/.zshrc
}

function mkcd {
    mkdir -p "$1" && cd "$1"
}

# ===========================
# 📚 Sistema de Ayuda Mejorado
# ===========================
function help() {
    echo -e "\n\e[36m╔════════════════════════════════════════════════════════════════╗\e[0m"
    echo -e "\e[36m║               📚 AYUDA DE COMANDOS - BIGLEX J (ZSH)            ║\e[0m"
    echo -e "\e[36m╚════════════════════════════════════════════════════════════════╝\n\e[0m"
    
    echo -e "\e[33m🔗 NAVEGACIÓN RÁPIDA\e[0m"
    echo -e "\e[90m  .., ..., bjpro, bjpros, bjdav, bjyt, bgm, docs, aurora...\e[0m"
    
    echo -e "\e[33m\n🛠️  DESARROLLO\e[0m"
    echo -e "\e[90m  gs, ga [files], gcm 'mensaje', gp, gpl, dev, build...\e[0m"
    
    echo -e "\e[33m\n🎬 PRODUCCIÓN DE CONTENIDO\e[0m"
    echo -e "\e[90m  new-project  → Crear estructura de carpetas para nuevo video\e[0m"
    
    echo -e "\e[33m\n🤖 ELY INTELLIGENCE\e[0m"
    echo -e "\e[90m  ely-intelligence, live, vozely, add-video, add-karaoke\e[0m"
    
    echo -e "\e[33m\n🎨 UTILIDADES CREATIVAS\e[0m"
    echo -e "\e[90m  color-palette → Mostrar paleta de colores oficial\e[0m"
    
    echo -e "\e[33m\n🌐 WEB & REDES\e[0m"
    echo -e "\e[90m  open-biglexj, open-youtube\e[0m"
    
    echo -e "\e[33m\n⚙️  SISTEMA\e[0m"
    echo -e "\e[90m  system-info, check-space, update-profile, edit-profile\e[0m"
    
    echo -e "\n\e[36m💡 Tip: Escribe 'aliases' para ver la lista compacta\e[0m\n"
}

function aliases() {
    echo -e "\n\e[32m╔════════════════════════════════════════════════════════════════╗\e[0m"
    echo -e "\e[32m║                  🔗 ALIASES DISPONIBLES                        ║\e[0m"
    echo -e "\e[32m╚════════════════════════════════════════════════════════════════╝\n\e[0m"
    echo -e "\e[90m NAVEGACIÓN: .., ..., bjpro, bjpros, bjdes, bjdoc, bjimg, bjmus, bjvid, bjdav, bjyt, bgm, aurora, docs\e[0m"
    echo -e "\e[90m DESARROLLO: gs, ga, gcm, gp, gpl, dev, build, start, pni, clonar, renombrar\e[0m"
    echo -e "\e[36m\n💡 Tip: Escribe 'help' para ver descripciones detalladas\e[0m\n"
}

# ===========================
# 📁 SCRIPTS
# ===========================
alias screaming="pwsh $BASE_DRIVE/Proyectos/biglexj/Scripts/Estructure/setup-screaming-architecture.ps1"
function clonar() { python3 "$BASE_DRIVE/Proyectos/biglexj/Scripts/clonar_estructura.py" "$@"; }
function renombrar() { python3 "$BASE_DRIVE/Proyectos/biglexj/Scripts/renombrar_archivos_carpetas.py" "$@"; }

# ===========================
# 🌟 Mensaje de bienvenida final
# ===========================
echo -e "\n\e[32m🎉 ¡Terminal de Biglex J cargado exitosamente!\e[0m"
echo -e "\e[34m💡 Escribe 'help' para ver todos los comandos disponibles\e[0m"
echo -e "\e[36m📌 Escribe 'aliases' para ver solo la lista de comandos\e[0m"
echo -e "\e[35m🚀 ¡A programar y crear contenido épico!\e[0m\n"

# ===========================
# 🌍 Variables de Entorno
# ===========================

# Flutter
export PATH="$PATH:$HOME/Dev-Tools/SDK/Flutter/bin/"

# Java
export JAVA_HOME="$HOME/Dev-Tools/JDK/Java/jdk-23.0.1+11/"
export PATH="$PATH:$JAVA_HOME/bin"
export PATH=$PATH:$HOME/Dev-Tools/Build-Tools/Gradle/gradle-8.10.2/bin/

# Android
export ANDROID_SDK_ROOT=$HOME/Dev-Tools/SDK/Android/
export ANDROID_HOME=$ANDROID_SDK_ROOT
export PATH=$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin
export PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools
export PATH=$PATH:$ANDROID_SDK_ROOT/build-tools/34.0.0
export PATH=$PATH:$ANDROID_SDK_ROOT/emulator

# NVIDIA (para WSL con GPU)
export __NV_PRIME_RENDER_OFFLOAD=1
export __GLX_VENDOR_LIBRARY_NAME=nvidia
export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0

# Rust/Cargo
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# Brave
alias brave='brave --password-store=basic'

# NVM (Node Version Manager)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Supabase (supa-images)
export SUPABASE_URL="https://rjtvzejsfjnvedforugq.supabase.co"
export SUPABASE_KEY="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJqdHZ6ZWpzZmpudmVkZm9ydWdxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTkxNjA0NDQsImV4cCI6MjA3NDczNjQ0NH0.qkclyPzPPLDucYmRgqdA8lK593wLr67WtsiwDbhFScA"
alias supa-images='curl "$SUPABASE_URL/rest/v1/images" \
  -H "apikey: $SUPABASE_KEY" \
  -H "Authorization: Bearer $SUPABASE_KEY"'

fpath=(~/.zsh/completions $fpath)
