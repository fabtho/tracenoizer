#!/bin/sh
#-*-Shell-Script-*-	Time-stamp: <2003-02-22 20:01:28 bingalls>
#Copyright © 1998, 2003 by Bruce Ingalls bingalls(at)users.sourceforge.net
#See file COPYING for GPL license.
# $Id$
#<url: http://emacro.sourceforge.net/ >		<url: http://www.dotemacs.de/ >

#Script to install EMacro into /etc/skel from an RPM package
#Does this fail for older versions of rpm? (<=RH 7.2)
rpm -q emacs>/dev/null
if [ $? != 0 ]; then
    rpm -q xemacs>/dev/null
    if [ $? != 0 ]; then
	echo "This setup expects Emacs or XEmacs RPMs to be installed."
	echo "Install before proceeding."
	exit
    fi
fi

if [ ! $1 ]; then
    echo "Usage: `basename $0` ARG"
    echo "  where ARG is the emacro*.rpm filename to install"
    exit
fi

rpm -q emacro>/dev/null
if [ $? == 0 ]; then
    echo "EMacro already installed! Exiting..."
    exit
fi

#Must overwrite any existing /etc/skel/.emacs
if [ `id -u` != 0 ]; then
    echo "Please enter root password"
    su --command="rpm --force -Uvh $1"
else
    rpm --force -Uvh $1
fi

if [ $? == 0 ]; then
    echo "EMacro now installed."
else
    echo "Failed to install EMacro!"
fi
