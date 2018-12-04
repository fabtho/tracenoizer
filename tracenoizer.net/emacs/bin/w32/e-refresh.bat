@echo off
:: Script to clean EMacro's cache on MS Windows
:: Time-stamp: <2003-02-16 10:37:37 bingalls>
:: $Id: refresh.bat,v 1.0 2000/11/01 20:26:34 bingalls Exp $

:: Copyright © 1998,2002,2003	Bruce Ingalls bingalls(at)users.sourceforge.net
:: Copyright © 2002		Furlan Primus fprimus(at)users.sourceforge.net
:: See the file COPYING for license
:: <url: http://www.sourceforge.net/ >	<url: http://www.dotemacs.de/ >

:: test to see if HOME is set:
if (%HOME) == () goto nohome

echo Run 'e-refresh' every time you change *.el libraries in the filesystem
echo.
echo When you get the free Cygwin from http://sources.redhat.com/cygwin/
echo you should run bin/unix/e-refresh instead.
echo.

:: save present location:
:: echo exit|%comspec%/k  PROMPT @$N:$_@CD $P$_>%temp%\cf.bat

:: change to where the files are located
cd %HOME%\emacs\

:: delete the files
if exist preferences\e-xcache.el* del preferences\e-xcache.el
if exist preferences\e-cache.el* del preferences\e-cache.el

:: Obsolete code below may disappear, as EMacro no longer bytecompiles code
if exist *.elc del *.elc
if exist emacro\*.elc del emacro\*.elc
if exist preferences\*.elc del preferences\*.elc
if exist programmer\*.elc del programmer\*.elc
:: less likely annoyances:
if exist %HOME%\.emacs.elc del %HOME%\.emacs.elc
if exist %HOME%\_emacs.elc del %HOME%\_emacs.elc
if exist %HOME%\.xemacs\*.elc del %HOME%\.xemacs\*.elc

:: change back from whence we came
:: for %%x in (call del) do %%x %temp%\cf.bat
goto end

:nohome
echo.
echo Please set the HOME environment variable
echo as described in the Installation documentation.

:end
echo.
echo.
