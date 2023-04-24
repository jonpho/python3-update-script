#!/bin/bash

read -p "Have you previously setup Python 3 using Pyenv (y/n)? " formersetup

read -p "Is your terminal set to bash or zsh (bash/zsh) default is bash? " terminaltype

read -p "Please check pyenv version at https://formulae.brew.sh/formula/pyenv#default and enter the version number. (i.e. 2.0.3) " versionpyenv

if [ ${formersetup} = n ] || [ -z ${formersetup} ]
then
  echo Starting Clean Setup

  echo **Update Brew**
  brew update

  echo **Installing Pyenv**
  brew install pyenv

  if [ ${terminaltype} = bash ] || [ -z ${terminaltype} ]
  then
    echo **Appending Pyenv code to the Bash Profile**
    echo  -e 'if command -v pyenv 1>/dev/null 2>&1; then\neval "$(pyenv init --path)"\nfi' >> ~/.bash_profile

    echo **Sourcing Bash Profile**
    source ~/.bash_profile

    echo **Installing tcl-tk**
    brew install tcl-tk

    echo **Appending the tcl-tk code to the Bash Profile**
    echo 'export PATH="/usr/local/opt/tcl-tk/bin:$PATH"' >> ~/.bash_profile
    echo 'export LDFLAGS="-L/usr/local/opt/tcl-tk/lib"' >> ~/.bash_profile
    echo 'export CPPFLAGS="-I/usr/local/opt/tcl-tk/include"' >> ~/.bash_profile
    echo 'export PKG_CONFIG_PATH="/usr/local/opt/tcl-tk/lib/pkgconfig"' >> ~/.bash_profile

    echo **Sourcing Bash Profile**
    source ~/.bash_profile
  else
    echo **Appending Pyenv code to the ZSH Profile**
    echo  -e 'if command -v pyenv 1>/dev/null 2>&1; then\neval "$(pyenv init --path)"\nfi' >> ~/.zprofile

    echo **Sourcing ZSH Profile**
    source ~/.zprofile

    echo **Installing tcl-tk**
    brew install tcl-tk

    echo **Appending the tcl-tk code to the ZSH Profile**
    echo 'export PATH="/usr/local/opt/tcl-tk/bin:$PATH"' >> ~/.zprofile
    echo 'export LDFLAGS="-L/usr/local/opt/tcl-tk/lib"' >> ~/.zprofile
    echo 'export CPPFLAGS="-I/usr/local/opt/tcl-tk/include"' >> ~/.zprofile
    echo 'export PKG_CONFIG_PATH="/usr/local/opt/tcl-tk/lib/pkgconfig"' >> ~/.zprofile

    echo **Sourcing Bash Profile**
    source ~/.zprofile
  fi

  echo **tcl-tk 8.6 updating python-build script to work with pyenv install of python**
  sed -i '' 's/$CONFIGURE_OPTS ${!PACKAGE_CONFIGURE_OPTS} "${!PACKAGE_CONFIGURE_OPTS_ARRAY}" || return 1/$CONFIGURE_OPTS --with-tcltk-includes="-I\/usr\/local\/opt\/tcl-tk\/include" --with-tcltk-libs="-L\/usr\/local\/opt\/tcl-tk\/lib -ltcl8.6 -ltk8.6" ${!PACKAGE_CONFIGURE_OPTS} "${!PACKAGE_CONFIGURE_OPTS_ARRAY}" || return 1/' /usr/local/Cellar/pyenv/${versionpyenv}/plugins/python-build/bin/python-build

  echo **Install Python 3.8.8 in Pyenv**
  pyenv install 3.8.8

  echo **Setting 3.8.8 to Pyenv Global Version**
  pyenv global 3.8.8

  echo **Upgrading pip version**
  pip install --upgrade pip

  echo **Installing Setuptools**
  pip install setuptools

  echo **Installing Wheel**
  pip install wheel

  echo PLEASE RESTART ALL TERMINALS FOR THE CHANGES TO TAKE EFFECT

else
  echo Starting Shortened Setup

  echo **Update Brew**
  brew update

  echo **Upgrade Pyenv**
  brew upgrade pyenv

  echo **tcl-tk 8.6 updating python-build script to work with pyenv install of python**
  sed -i '' 's/$CONFIGURE_OPTS ${!PACKAGE_CONFIGURE_OPTS} "${!PACKAGE_CONFIGURE_OPTS_ARRAY}" || return 1/$CONFIGURE_OPTS --with-tcltk-includes="-I\/usr\/local\/opt\/tcl-tk\/include" --with-tcltk-libs="-L\/usr\/local\/opt\/tcl-tk\/lib -ltcl8.6 -ltk8.6" ${!PACKAGE_CONFIGURE_OPTS} "${!PACKAGE_CONFIGURE_OPTS_ARRAY}" || return 1/' /usr/local/Cellar/pyenv/${versionpyenv}/plugins/python-build/bin/python-build

  echo **Install Python 3.8.8 in Pyenv**
  pyenv install 3.8.8

  echo **Seting 3.8.8 to Pyenv Global Version**
  pyenv global 3.8.8

  echo **Upgrading pip version**
  pip install --upgrade pip

  echo **Installing Setuptools**
  pip install setuptools

  echo **Installing Wheel**
  pip install wheel

  echo PLEASE RESTART ALL TERMINALS FOR THE CHANGES TO TAKE EFFECT
fi
