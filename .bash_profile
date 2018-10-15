# https://superuser.com/questions/183870/difference-between-bashrc-and-bash-profile

if [ -f "$HOME/.bashrc" ]; then
. "$HOME/.bashrc"
fi

JAVA_HOME="$HOME/local/jdk1.8.0_181"
GRADLE_HOME="$HOME/local/gradle-4.10.2"
PATH="$JAVA_HOME/bin:$HOME/local:$HOME/p/bin:$HOME/p/gos/go1.11/bin:$GRADLE_HOME/bin:$PATH:."

