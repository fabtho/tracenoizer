# $Id: skel.cshrc,v 1.2 1998/04/20 11:41:33 luisgh Exp $
# Luis Francisco González <luisgh@debian.org> based on that of Vadik Vygonets
# Please check /usr/doc/tcsh/examples/cshrc to see other possible values.
if ( $?prompt ) then
  set autoexpand
  set autolist
  set cdpath = ( ~ )
  set pushdtohome

# Load aliases from ~/.alias
  if ( -e ~/.alias )	source ~/.alias

endif
