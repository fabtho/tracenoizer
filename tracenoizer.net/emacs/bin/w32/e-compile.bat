@echo off
echo "This script might not be working properly. In that case, download Cygwin"
echo "<url: http://www.cygwin.com/ >. Then run bin/unix/e-compile"
:: Email me, if you've fixed or tested this batch file, thanks!

:: compile: byte-compiles *.el files for faster loading
:: Time-stamp: <2003-02-16 10:37:37 bingalls>
:: $Id$
:: Copyright © 1998,2002,2003	Bruce Ingalls bingalls(at)users.sourceforge.net
:: Copyright © 2002		Furlan Primus fprimus(at)users.sourceforge.net
:: See the file COPYING for license
:: <url: http://emacro.sourceforge.net/ >	<url: http://www.dotemacs.de/ >

::Syntax: compile foo.el bar.el *.el

::Note: DOS limits are 128 chars/line. * wildcards may not be straightforward.

::I recommend that you do *not* compile EMacro's *.el elisp files. You will not
::gain much speed, and will lose portablility between versions & Emacs/XEmacs.
::You can can easily byte-compile individual files, by opening them in Emacs,
::then choosing menu: Lisp->Compile. Some packages, such as Semantic, used by
::JDE, benefit from compiling multiple files. You can recognize them, because
::they include Makefiles. Assuming that Make is available on your system, you
::may still get errors, because dependent libraries, such as ELib are not in
::your load-path. This script simply adds EMacro's load-path


if (%HOME) == () goto nohome
if exist %HOME%/emacs/e-path.el goto run

echo.
echo Cannot find %HOME%/emacs/e-path.el
echo Please read Installation documentation.
echo.
echo.

:run
emacs -batch -l %HOME%/emacs/e-path.el -f batch-byte-compile %1 %2 %3 %4 %5 %6 %7 %8 %9
goto end

:nohome
echo.
echo Please set the HOME environment variable
echo as described in the Installation documentation.
echo.
echo.

:end
