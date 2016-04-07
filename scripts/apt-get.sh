set -ex
export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get upgrade -y
apt-get install -y g++ git libboost-dev tmux man wget bzip2 emacs
