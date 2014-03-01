# History stuff
HISTFILE=~/.zsh_history
HISTSIZE=5000000000
SAVEHIST=5000000000
LS_COLORS='rs=0:di=01;36:ln=00;35:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lz=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.rar=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.axv=01;35:*.anx=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.axa=00;36:*.oga=00;36:*.spx=00;36:*.xspf=00;36:';
ZLS_COLORS=$LS_COLORS
eval `dircolors -b`

# Variables
export LS_COLORS
export ZLS_COLORS
export EDITOR="vim"
export PAGER=/usr/bin/vimpager

setopt appendhistory
setopt autopushd pushdminus pushdsilent pushdtohome
setopt autocd
setopt cdablevars
setopt ignoreeof
setopt interactivecomments
setopt nobanghist
#setopt noclobber
setopt HIST_REDUCE_BLANKS
setopt HIST_IGNORE_SPACE
setopt SH_WORD_SPLIT
setopt nohup
setopt notify
setopt hist_ignore_all_dups
setopt extendedglob
# Allow for functions in the prompt.
setopt PROMPT_SUBST
unsetopt beep

PROMPT='%{${fg[blue]}%}[%n@%m][\$ ' # default prompt
RPROMPT='][%{${fg[green]}%}%B%~%b$(prompt_git_info)%{${fg[default]}%} %T]'

typeset -gU path cdpath manpath fpath

# Enable auto-execution of functions.
typeset -ga preexec_functions
typeset -ga precmd_functions
typeset -ga chpwd_functions

autoload -Uz compinit promptinit colors
compinit
promptinit
colors

# Autoload zsh functions.
fpath=(~/.zsh/functions $fpath)
autoload -U ~/.zsh/functions/*(:t)

bindkey -e
bindkey ' ' magic-space # also do history expansion on space
typeset -g -A key
#bindkey '\e[3~' delete-char
bindkey '\e[1~' beginning-of-line
bindkey '\e[4~' end-of-line
#bindkey '\e[2~' overwrite-mode
bindkey '^[[1~' beginning-of-line
bindkey '^[[5~' up-line-or-history
bindkey '^[[3~' delete-char
bindkey '^[[4~' end-of-line
bindkey '^[[6~' down-line-or-history
bindkey '^[[A' up-line-or-search
bindkey '^[[D' backward-char
bindkey '^[[B' down-line-or-search
bindkey '^[[C' forward-char
# home/end for rxvt
bindkey "\e[8~" end-of-line
bindkey "\e[7~" beginning-of-line
bindkey "^D" clear-and-exit
bindkey . rationalise-dot

# Comp stuff
zmodload zsh/complist
zstyle :compinstall filename '${HOME}/.zshrc'
zstyle ':completion:*:functions' ignored-patterns '_*'
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle -e ':completion:*' special-dirs '[[ $PREFIX = (../)#(|.|..) ]] && reply=(..)'
zstyle ':completion:*:descriptions' format $'%{\e[0;31m%}completing %B%d%b%{\e[0m%}'
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %P Lines: %m
zstyle ':completion:*:corrections' format $'%{\e[0;31m%}%d (errors: %e)%}'
zstyle ':completion:*:complete:-command-::commands' ignored-patterns '*\~'
zstyle ':completion:*' file-sort name
#zstyle ':completion:*' menu select=long
#zstyle ':completion:*-case' menu select=5
zstyle ':completion:*' menu select=long-list select=3 # Enable menu completion if 3 or more alternatives
zstyle -e ':completion:*:approximate:*' max-errors 'reply=( $((($#PREFIX+$#SUFFIX)/3 )) numeric )'
zstyle ':completion:*:expand:*' tag-order all-expansions
# allow approximate
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric
# tab completion for PID
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*' force-list always
zstyle ':completion:*:*:killall:*' menu yes select
zstyle ':completion:*:killall:*' force-list always
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:*:killall:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
# cd not select parent dir.
zstyle ':completion:*:cd:*' ignore-parents parent pwd
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh_cache

zstyle ':completion:*' completer _complete _list _oldlist _expand _ignored _match _correct _approximate _prefix
zstyle ':completion:*' list-colors $(dircolors) # Use colors in the menu selection
zstyle ':completion:*' glob 'yes' # Expand globs when tab-completing
zstyle ':completion:*:functions' ignored-patterns '_*' # Ignore completion functions for unavailable commands
zstyle ':completion:*' accept-exact '*(N)' # Speed up path completion, by avoiding partial globs

zstyle ':completion:*:complete:-command-::commands' ignored-patterns '*\~' # Don't complete backup files as executables
zstyle ':completion:*' ignore-parents parent pwd # Don't let ../<tab> match $PWD
zstyle ':completion::*:(rm|vi):*' ignore-line true # Don't match the same filenames multiple times

# SSH Completion
zstyle ':completion:*:scp:*' tag-order \
   files users 'hosts:-host hosts:-domain:domain hosts:-ipaddr"IP\ Address *'
zstyle ':completion:*:scp:*' group-order \
   files all-files users hosts-domain hosts-host hosts-ipaddr
zstyle ':completion:*:ssh:*' tag-order \
   users 'hosts:-host hosts:-domain:domain hosts:-ipaddr"IP\ Address *'
zstyle ':completion:*:ssh:*' group-order \
   hosts-domain hosts-host users hosts-ipaddr

# aliases
alias less=$PAGER
alias more=$PAGER
alias zless=$PAGER
alias ls='ls -lha --color=always'
alias sl='ls -lha --color=always'
alias grep='grep --color=always'
alias df='df -hT'
alias ping='ping -c 3'
alias rm="rm -v"
alias mv="mv -v"
alias top='htop'
alias ps='ps faux'
alias du='du -sh'
alias free='free -m'
alias untbz2='tar -xjvf'
alias untgz='tar -xzvf'
alias brzinski='python2.7 -m SimpleHTTPServer'
alias mount='mount -vv'
alias gping='ping google.com'
alias myip="curl -s checkip.dyndns.org | grep -Eo '[0-9\.]+'"
alias screencast="ffmpeg -f x11grab -r 25 -s 1280x800 -i :0.0 /tmp/screencast.mpg"
alias graball="ffmpeg -y -f alsa -ac 2 -i hw:0,0 -f x11grab -r 30 -s `xdpyinfo | grep 'dimensions:'|awk '{print $2}'` -i :0.0 -acodec pcm_s16le /tmp/output.wav -an -acodec pcm_s16le -vcodec libx264 -preset ultrafast -crf 0 -threads 0 /tmp/output.mp4"
alias twit.tv='mplayer http://bglive-a.bitgravity.com/twit/live/high'
alias webcam="mplayer -fps 24 tv://"
alias sopcast="mplayer http://127.0.0.1:8908/tv.asf"
#alias webcam="mplayer tv:// -tv driver=v4l:width=352:height=288:device=/dev/video0 "
alias fabric="fab -f /srv/http/m3com/scripts/python/deploy/fabfile.py"
alias g='git'
alias gb='git branch -v'
alias gc='git commit -a -m'
alias gba='git branch -a'
alias gcv='git commit -v'
alias gcm='git commit -m'
alias gl='git pull --rebase'
alias gp='git push'
alias gst='git status'
alias gsh='git show'
alias gpull='git pull origin $(current_branch)'
alias gpush='git push origin $(current_branch)'
alias gd='git diff --color'
alias gdc='git diff --cached'
alias gf='git diff --stat --color'
alias git-diff-branch='git diff --stat --color master..staging'
alias git-deleted="git log --all --pretty=format: --name-only --diff-filter=D | sort -u"
alias begraund='feh --bg-scale'
alias firefox='firefox -no-remote -no-remote -ProfileManager'
alias devping='ping 192.168.0.240'
#alias netbeans='netbeans --laf GTK'
alias plantronics='bluez-simple-agent hci0 00:1C:EF:7E:A1:88'
alias pmplayer='mplayer -ao alsa:device=btheadset'
#alias drush='/usr/bin/php /home/play/stuff/drupal/drush/drush.php'
#alias firedatabases="for database in ~/.mozilla/firefox/*/*.sqlite; do echo processing $database... ; sqlite3 $database 'VACUUM;'; done ;"
alias dozeboot='VBoxManage startvm sept'
alias tvfeed="curl 'http://api.dailytvtorrents.org/1.0/shows.getTextInfo?show_names=suits,grimm,dexter,the-big-bang-theory,breaking-bad,eureka,the-mentalist,warehouse-13,fringe,burn-notice,top-gear,castle,game-of-thrones&colors=yes&links=yes'"
alias clear="echo NO!"
alias fmplayer="mplayer /proc/`pidof plugin-container`/fd/15"

# custom completion commands
#local _myhosts
#_myhosts=( ${${${${(f)"$(<$HOME/.ssh/known_hosts)"}:#[0-9]*}%%\ *}%%,*} )
#zstyle ':completion:*' hosts $_myhosts

rmmodcomplete () { reply=(`/sbin/lsmod|cut -f1 -d" "|grep -v Module`) }
compctl -K rmmodcomplete rmmod

function insmodcomplete() { reply=(`find /lib/modules/$(uname -r)/* ! -type d -printf "%f\n"|sed "s/\.o$//"`) }
compctl -K insmodcomplete insmod modprobe

compile=(install clean remove uninstall deinstall)
compctl -k compile make

compctl -k '(up commit checkout update status)' svn
compctl -k ping telnet ncftp host nslookup irssi rlogin ftp

compctl -j -P '%' fg jobs disown
compctl -g '*.(gz|z|Z|t[agp]z|tarZ|tz)' + -g '*(-/)' gunzip gzcat zcat
compctl -g '*.(mp3|MP3|ogg|OGG|wav|WAV)' + -g '*(-/)' mpc mpg123 mpg321 xmms
compctl -g "*.html *.htm" + -g "*(-/) .*(-/)" + -H 0 '' remurl lynx links wget opera
compctl -g '*.(pdf|PDF)(ps|PS)' + -g '*(-/)' gv
compctl -g '*(-/)' + -g '.*(/)' cd chdir dirs pushd rmdir dircmp cl tree
compctl -g '*.(jpg|JPG|jpeg|JPEG|gif|GIF|png|PNG|bmp)' + -g '*(-/)' qiv gimp feh
compctl -g '*.tex*' + -g '*(-/)' {,la,gla,ams{la,},{g,}sli}tex texi2dvi
compctl -g '*.dvi' + -g '*(-/)' xdvi
compctl -g '[^.]*(-/) *.(c|C|cc|c++|cxx|cpp)' + -f cc CC c++ gcc g++

compctl -f -x 'S[1][2][3][4][5][6][7][8][9]' -k '(1 2 3 4 5 6 7 8 9)' \
  - 'R[[1-9nlo]|[1-9](|[a-z]),^*]' -K 'match-man' \
  - 's[-M],c[-1,-M]' -g '*(-/)' \
  - 's[-P],c[-1,-P]' -c \
  - 's[-S],s[-1,-S]' -k '( )' \
  - 's[-]' -k '(a d f h k t M P)' \
  - 'p[1,-1]' -c + -K 'match-man' \
  -- man

function clear-and-exit() {
  zle kill-whole-line
  exit
}
zle -N clear-and-exit

function rationalise-dot() {
  if [[ $LBUFFER = *.. ]]; then
LBUFFER+=/..
  else
LBUFFER+=.
  fi
}
zle -N rationalise-dot

function current_branch() {
  echo $__CURRENT_GIT_BRANCH
}

function dual-right-of () {
  xrandr --output VGA1 --primary --right-of LVDS1 --output LVDS1 --auto
}

function dual-left-of () {
  xrandr --output VGA1 --primary --left-of LVDS1 --output LVDS1 --auto
}

function single-vga () {
  xrandr --output LVDS1 --off
  xrandr --output VGA1 --auto
}

function single-lvds () {
  xrandr --output VGA1 --off
  xrandr --output LVDS1 --auto
}

function vacuum-mozilla() {
  for i in ~/.mozilla/firefox/mufwh4cg.default/*.sqlite
  do
echo "VACUUM;"|sqlite3 $i
      echo "REINDEX;"|sqlite3 $i
  done
}

function ll () {
  ls -l "$@"| egrep "^d" ; ls -lXB "$@" 2>&-| egrep -v "^d|total ";
}

function most_useless_use_of_zsh {
   local lines columns colour a b p q i pnew
   ((columns=COLUMNS-1, lines=LINES-1, colour=0))
   for ((b=-1.5; b<=1.5; b+=3.0/lines)) do
for ((a=-2.0; a<=1; a+=3.0/columns)) do
for ((p=0.0, q=0.0, i=0; p*p+q*q < 4 && i < 32; i++)) do
               ((pnew=p*p-q*q+a, q=2*p*q+b, p=pnew))
           done
           ((colour=(i/4)%8))
            echo -n "\\e[4${colour}m "
        done
echo
done
}

# Append git functions needed for prompt.
preexec_functions+='preexec_update_git_vars'
precmd_functions+='precmd_update_git_vars'
chpwd_functions+='chpwd_update_git_vars'
unset MAILCHECK

# Welcome message... #################################################
if [ -x /usr/bin/fortune ]; then ##
    /usr/bin/fortune -s # makes our day a bit more fun.... :-) ##
fi ##
#####################################################################
