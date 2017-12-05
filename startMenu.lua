local nk = require "nuklear"

local windowW = 300
local windowH = 250

return function()
	if nk.windowBegin('startMenu', 250, 250, windowW, windowH, 'border') then
		local x, y, w, h = nk.windowGetBounds()
		nk.layoutRow('dynamic', windowH, 1)
		nk.groupBegin('Group 2')
			nk.layoutRow('dynamic', 30, 1)
			nk.spacing(.5)
			if nk.button("Start") then
				gamestate = "game"
			end
			nk.spacing(1)
			if nk.button("Instructions") then
			end
			nk.spacing(1)
			if nk.button("Quit") then
				love.event.push("quit")
			end
		nk.groupEnd()
	end
	nk.windowEnd()
end