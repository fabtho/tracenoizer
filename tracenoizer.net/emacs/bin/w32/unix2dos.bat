:: Convert Unix End Of Lines to MS Windows
:: Time-stamp: <2003-02-16 10:37:36 bingalls>
:: $Id: install.bat,v 1.9 2000/11/01 20:26:34 bingalls Exp $

:: Copyright © 2002	Furlan Primus fprimus(at)users.sourceforge.net
:: See the file COPYING for license
:: <url: http://emacro.sourceforge.net/ >	<url: http://www.dotemacs.de/ >

@echo off
@cls

:: Convert unix style text files to dos style
:: Required to run batch files

:: Quit, if file argument doesn't exist
if exist %1 goto convert
echo.
echo Syntax: unix2dos filename
echo Filename arg missing
echo.
echo Requires perl.exe to be installed in PATH
echo.
goto end

:convert
perl -i.lf -pe "s/[\012]/\015\012/g;" %1 %2 %3 %4 %5 %6 %7 %8 %9

:end
