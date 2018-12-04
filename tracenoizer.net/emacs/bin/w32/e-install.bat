@echo off
echo "If you have problems with this batch file, download Cygwin"
echo "<url: http://www.cygwin.com/ >. Then run ~/emacs/bin/unix/e-install"
:: Email me, if you've fixed or tested this batch file, thanks!

:: Installation script for EMacro on MS Windows
:: Time-stamp: <2003-02-16 10:37:37 bingalls>
:: $Id: install.bat,v 1.9 2000/11/01 20:26:34 bingalls Exp $

:: Copyright © 1998,2002,2003	Bruce Ingalls bingalls(at)users.sourceforge.net
:: Copyright © 2002		Furlan Primus fprimus(at)users.sourceforge.net
:: See the file COPYING for license
:: <url: http://emacro.sourceforge.net/ >	<url: http://www.dotemacs.de/ >

if %HOME% == () goto nohome
goto home

:nohome
echo "EMacro recommends that you set the HOME environment variable, either by"
echo "Control Panel - System [NT], or for Windows 98, add this to your"
echo "autoexec.bat:"
echo "	set HOME=c:\path\to\emacro"
echo -
echo "Continuing; default is usually C:\"
echo "This batch file simply renames init.el to .emacs and clears any EMacro"
echo "caches. You can still set HOME, and move EMacro there"
echo -

:home
echo Installing EMacro in Home of %HOME%
move %HOME%\init.el %HOME%\_emacs
if errorlevel 1 goto failed

if exist %HOME%\emacs\preferences\e-xcache.el del %HOME%\emacs\preferences\e-xcache.el
if exist %HOME%\emacs\preferences\e-cache.el del %HOME%\emacs\preferences\e-cache.el
if exist %HOME%\emacs\preferences\*.elc del %HOME%\emacs\preferences\*.elc

echo EMacro installed. Launch Emacs and enjoy!
goto end

:failed
echo Install failed. You may have to rename %HOME%\init.el to %HOME%\_emacs

:end
echo --
echo "Help -> EMacro from Emacs or XEmacs menu launches doc/index.html"
echo --
echo if you don't see the menu in Emacs, hit F10 key or Alt `.
