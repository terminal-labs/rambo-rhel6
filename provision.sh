echo "provisioning!"
echo $PWD

BIN=~/bin
DOWNLOADS=~/downloads

mkdir -p $BIN
mkdir -p $DOWNLOADS


# disable subscription manager: https://sahlitech.com/entitlement-server-fix/
sudo sed -i s/enabled=1/enabled=0/g /etc/yum/pluginconf.d/subscription-manager.conf

sudo rm /etc/yum.repos.d/*

# Replace the rhel6 repos with centos6, which are eol
# https://perifery.atlassian.net/wiki/spaces/KB/pages/1670578177/CSN+-+Fixing+the+CentOS+6+yum+repository
sudo cp rhel6/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo
sudo cp rhel6/epel.repo /etc/yum.repos.d/epel.repo
sudo cp rhel6/RPM-GPG-KEY-CentOS-6 /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-6

sudo yum clean all
sudo yum check-update

# https://stackoverflow.com/a/27674776/913080
sudo yum install https://opensource.wandisco.com/centos/6/git/x86_64/wandisco-git-release-6-1.noarch.rpm -y

sudo yum install nano git tree -y

(
    cd $DOWNLOADS
    wget https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep-13.0.0-x86_64-unknown-linux-musl.tar.gz
    tar -xvzf ripgrep-13.0.0-x86_64-unknown-linux-musl.tar.gz
    cp ripgrep-13.0.0-x86_64-unknown-linux-musl/rg $BIN/rg

    wget https://ftp.gnu.org/pub/gnu/emacs/emacs-28.2.tar.gz --no-check-certificate
    tar -xvzf emacs-28.2.tar.gz
    (
        cd emacs-28.2/
        ./configure --with-gnutls=ifavailable
        make
        sudo make install
    )
)
