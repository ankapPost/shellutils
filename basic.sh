
alias grep='grep --color'                     # show differences in colour
alias egrep='egrep --color=auto'              # show differences in colour
alias fgrep='fgrep --color=auto'              # show differences in colour
#
# Some shortcuts for different directory listings
alias ls='ls -hF --color=tty'                 # classify files in colour
alias dir='ls --color=auto --format=vertical'
alias vdir='ls --color=auto --format=long'
alias ll='ls -lA'                             # long list
alias la='ls -A'                              # all but . and ..
alias l='ls -CF'                              #

function set_geometry {
	disp=`xrandr | grep -e " connected [^(]" | awk '{print $1}'`
	echo Setted disp as: $disp

	tmp=`cvt $1 $2 $3 | grep Modeline`
	# tmp=`cvt 1200 900 60 | grep Modeline`
	name=`echo $tmp | awk '{print $2}' | sed -e 's/"//g'`
	echo Setted name as: $name
	modline=`echo $tmp | awk '{$1="";$2=""}1' | sed -e 's/^\s+//'`
	echo Setted modline as: $modline

	echo Executing: xrandr --newmode $name $modline
	xrandr --newmode $name $modline

	echo Executing: xrandr --addmode $disp $name
	xrandr --addmode $disp $name

	echo Executing: xrandr -s $name
	xrandr -s $name
}

export HISTCONTROL=ignoredups:erasedups  # no duplicate entries
export HISTSIZE=1000000
export HISTFILESIZE=1000000
export HISTTIMEFORMAT='%F %T '
shopt -s histappend                      # append to history, don't overwrite it
# Save and reload the history after each command finishes
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

export PS1="\[\e[1;32m\]\u\[\e[37m\]@\[\e[33m\]\h \[\e[36m\]\w\[\e[m\] > "