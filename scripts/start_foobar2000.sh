#!/usr/bin/env sh

main()
{
	export WINEPREFIX="$HOME/.wine"
	export DYLD_FALLBACK_LIBRARY_PATH=/usr/X11/lib
	export FREETYPE_PROPERTIES="truetype:interpreter-version=35"
	cd "$WINEPREFIX/drive_c/Program Files (x86)/foobar2000" || return
	wine foobar2000.exe &
}

main
