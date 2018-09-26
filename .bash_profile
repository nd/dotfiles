# https://superuser.com/questions/183870/difference-between-bashrc-and-bash-profile

if [ -f "$HOME/.bashrc" ]; then
. "$HOME/.bashrc"
fi

JAVA_HOME="$HOME/local/jdk1.8.0_181"
PATH="$JAVA_HOME/bin:$HOME/local:$HOME/p/bin:$PATH:."

