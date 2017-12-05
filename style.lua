local nk = require 'nuklear'

local colors = {
	['text'] = '#000000',
	['window'] = nk.colorRGBA(131,3,3),
	['header'] = nk.colorRGBA(212,0,0),
	['border'] = nk.colorRGBA(212,0,0),
	['button'] = nk.colorRGBA(255,200,3),
	['button hover'] = '#ff0000',
	['button active'] = nk.colorRGBA(212,0,0),
	['toggle'] = '#646464',
	['toggle hover'] = '#787878',
	['toggle cursor'] = '#2d2d2d',
	['select'] = '#2d2d2d',
	['select active'] = '#232323',
	['slider'] = '#262626',
	['slider cursor'] = '#646464',
	['slider cursor hover'] = '#787878',
	['slider cursor active'] = '#969696',
	['property'] = nk.colorRGBA(212,0,0),
	['edit'] = '#262626',
	['edit cursor'] = '#afafaf',
	['combo'] = '#2d2d2d',
	['chart'] = '#787878',
	['chart color'] = '#2d2d2d',
	['chart color highlight'] = '#ff0000',
	['scrollbar'] = '#282828',
	['scrollbar cursor'] = '#646464',
	['scrollbar cursor hover'] = '#787878',
	['scrollbar cursor active'] = '#969696',
	['tab header'] = '#282828'
}

local colorNames = {}

for name,_ in pairs(colors) do
	colorNames[#colorNames + 1] = name
end

table.sort(colorNames)

return function ()
	nk.styleLoadColors(colors)
end