##
## Atelier Dune
## Bram De Haan @ (http://atelierbram.github.io/syntax-highlighting/atelier-schemes/dune)
##

evaluate-commands %sh{
	base00='rgb:20201D'
	base01='rgb:292824'
	base02='rgb:6E6B5E'
	base03='rgb:7D7A68'
	base04='rgb:999580'
	base05='rgb:A6A28C'
	base06='rgb:E8E4CF'
	base07='rgb:FEFBEC'
	base08='rgb:D73737'
	base09='rgb:B65611'
	base0A='rgb:CFB017'
	base0B='rgb:60AC39'
	base0C='rgb:1FAD83'
	base0D='rgb:6684E1'
	base0E='rgb:B854D4'
	base0F='rgb:D43552'


## code
	echo "
		face global value ${base09}+b
		face global type ${base0A}
		face global identifier ${base08}
		face global string ${base0B}
		face global error ${base05},${base0B}
		face global keyword ${base0E}+b
		face global operator ${base05}
		face global attribute ${base09}
		face global comment ${base03}
		face global meta ${base0A}

"

## markup
	echo "
		face global title ${base0D}
		face global header ${base0D}
		face global bold ${base0A}
		face global italic ${base09}
		face global mono ${base0B}
		face global block ${base09}
		face global link ${base0D}
		face global bullet ${base0B}
		face global list ${base08}

"

## builtin
	echo "
		face global Default ${base05},${base00}
		face global PrimarySelection ${base07},${base0D}
		face global SecondarySelection ${base05},${base0D}
		face global PrimaryCursor ${base00},${base07}
		face global SecondaryCursor ${base00},${base05}
		face global LineNumbers ${base05},${base01}
		face global LineNumberCursor ${base05},rgb:282828+b
		face global MenuForeground ${base07},${base0D}
		face global MenuBackground ${base0D},${base01}
		face global MenuInfo ${base0D}
		face global Information ${base00},${base0D}
		face global Error ${base01},${base08}
		face global StatusLine ${base06},${base01}
		face global StatusLineMode ${base0A}
		face global StatusLineInfo ${base0D}
		face global StatusLineValue ${base0B}
		face global StatusCursor ${base02},${base0D}
		face global Prompt ${base0A},${base00}
		face global MatchingChar ${base0D},${base00}+b
		face global BufferPadding ${base0D},${base01}

"

}