#!/bin/sh
#-*-Shell-Script-*-	Time-stamp: <2003-04-03 18:52:42 bingalls>
#Copyright © 1998, 2003 by Bruce Ingalls bingalls@users.sourceforge.net
#See file COPYING for GPL license.
# $Id$
#<url: http://emacro.sourceforge.net/ >		<url: http://www.dotemacs.de/ >

#Script to build EMacro RPM package. For maintainers, not end users

INSTALLER=emacro

if [ $# -ne 1 ]; then
    echo "`basename $0` [rpm|deb]"
    echo "Where EPM has been installed from http://www.easysw.com/"
    echo "You must choose one of 2 args:"
    echo "rpm	generates a Red Hat compatible package"
    echo "deb	generates a Debian compatible package"
else
    if [ -f $INSTALLER.list ]; then
	epm -v -g -ns -f $1 $INSTALLER
    else
	echo "$INSTALLER.list not found in the current directory"
    fi
fi
