##
## Tomorrow
## Chris Kempson @ (http://chriskempson.com)
##

evaluate-commands %sh{
	base00='rgb:1D1F21'
	base01='rgb:282A2E'
	base02='rgb:373B41'
	base03='rgb:969896'
	base04='rgb:B4B7B4'
	base05='rgb:C5C8C6'
	base06='rgb:E0E0E0'
	base07='rgb:FFFFFF'
	base08='rgb:CC6666'
	base09='rgb:DE935F'
	base0A='rgb:F0C674'
	base0B='rgb:B5BD68'
	base0C='rgb:8ABEB7'
	base0D='rgb:81A2BE'
	base0E='rgb:B294BB'
	base0F='rgb:A3685A'


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