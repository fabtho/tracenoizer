#!/bin/sh
#-*-Shell-Script-*-	Time-stamp: <2003-02-16 10:31:46 bingalls>
#Copyright C 1998, 2003 by Bruce Ingalls bingalls(at)users.sourceforge.net
#See file COPYING for GPL license.
# $Id$
#<url: http://emacro.sourceforge.net/ >		<url: http://www.dotemacs.de/ >
# Fixed invalid paths/syntax <2003-01-12 14:11:08 vls>

#Script to install EMacro into existing account's HOME from an EMacro package
#installed in /etc/skel
if [ ! -d "/etc/skel/emacs" ]; then
    echo "This setup expects an EMacro package to be installed into /etc/skel."
    echo "Install EMacro there, before proceeding."
    exit
fi

if grep emacro $HOME/.emacs >/dev/null 2>&1
then
    echo "EMacro already installed. Assuming an upgrade and proceeding."
else [ -f "$HOME/.emacs" ]
    pid="$$"			    # Rename ~/.emacs with pid extension
	echo "Moving existing $HOME/.emacs. to $HOME/.emacs.$pid"
    mv -f $HOME/.emacs $HOME/.emacs.$pid >/dev/null 2>&1
	unset -v pid  # Bash says this is inherited from Bourne shell so we
	              # shouldn't barf on non-bash shells.
fi

cp /etc/skel/.emacs $HOME
cp -R /etc/skel/emacs $HOME

/etc/skel/emacs/bin/unix/e-refresh
echo "EMacro now installed."
