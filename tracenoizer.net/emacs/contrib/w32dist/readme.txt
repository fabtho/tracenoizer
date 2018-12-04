You must set the HOME environment variable in
    Control Panel : System : Advanced Settings

If you are running Windows 98 or older, you can set HOME in autoexec.bat with
   SET HOME=C:\home
and then reboot

Otherwise, EMacro will attempt to install in C:\ - This is not recommended.

If you have a .emacs or _emacs file (other than EMacro's) in the install directory, you should move it before proceeding. .emacs will be overwritten and _emacs may interfere with EMacro.