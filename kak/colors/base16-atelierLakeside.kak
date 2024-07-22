##
## Atelier Lakeside
## Bram De Haan @ (http://atelierbram.github.io/syntax-highlighting/atelier-schemes/lakeside/)
##

evaluate-commands %sh{
	base00='rgb:161B1D'
	base01='rgb:1F292E'
	base02='rgb:516D7B'
	base03='rgb:5A7B8C'
	base04='rgb:7195A8'
	base05='rgb:7EA2B4'
	base06='rgb:C1E4F6'
	base07='rgb:EBF8FF'
	base08='rgb:D22D72'
	base09='rgb:935C25'
	base0A='rgb:8A8A0F'
	base0B='rgb:568C3B'
	base0C='rgb:2D8F6F'
	base0D='rgb:257FAD'
	base0E='rgb:5D5DB1'
	base0F='rgb:B72DD2'


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