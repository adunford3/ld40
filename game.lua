-- required modules
local nk = require 'nuklear'
Object = require "lib.classic"
require "family"
require "dataController"

-- Global variables


--local variables
local detailFamily = families[1]

--[[

TODO: Add win/lose conditions based on number of screwups
TODO: Add role/food calculation
TODO: Add total food (this may need another level for hated/liked role of regime or tweak starvation numbers <- Test!)
TODO: Add flavor text to win/lose conditions
TODO: Add instructions with flavor text
TODO: Figure out building and hosting!

]]

return function()
currentProd = calculateProd()
	-- top menu
	if nk.windowBegin('topMenu', 0, 0, 800, 40, 'border') then
		local x, y, w, h = nk.windowGetBounds()
		nk.menubarBegin()
		nk.layoutRow('dynamic', 30, 1)
		if nk.menuBegin("Menu", nil, 120, 90) then
			nk.layoutRow('dynamic', 40, 1)
			if nk.menuItem("Start Menu") then
				gamestate = "startMenu"
			end
			if nk.menuItem("Quit") then 
				love.event.push("quit")
			end
			nk.menuEnd()
		end
		nk.menubarEnd()
	end
	nk.windowEnd()

	-- family list
	if nk.windowBegin('Families', 5, 45, 295, 400, 'border', 'title') then
		nk.layoutRow('dynamic', 400, 1)
		nk.groupBegin("Group 1")
			nk.layoutRow('dynamic', 30, 1)
			for i=1,famLength do
				-- print(famLength)
				if nk.button(families[i].name.." Family") then
					detailFamily = families[i]
				end
			end
		nk.groupEnd()
	end
	nk.windowEnd()

	-- family detail window
	if nk.windowBegin('Detail View', 305, 45, 490, 400, 'border', 'title') then
		local x, y, w, h = nk.windowGetBounds()
		nk.layoutRow('dynamic', 400, 2)
		nk.groupBegin('portrait')
			nk.layoutRow('dynamic', 20, 1)
			nk.label(detailFamily.name.." Family")
			nk.image(detailFamily.image, x + 20, y + 65, 180, 186)
			nk.spacing(9)
			nk.label("Description")
		nk.groupEnd()
		nk.groupBegin("status")
			nk.layoutRow('dynamic', 20, 1)
			nk.label("Pre-Revolution Role: "..detailFamily.prRole)
			nk.label("Current Role: "..detailFamily.cRole)
			nk.label("Family Size: "..detailFamily.famSize)
			nk.label("Last Month's Rations: "..detailFamily.lastFood.."/4")
			updateFamProd(detailFamily)
			nk.label("Production: "..(detailFamily.production * 100).."%")
			nk.label("Status: "..detailFamily.status)
			nk.spacing(1)
			nk.layoutRow('dynamic', 40, 1)
			detailFamily.currFood = nk.property("Rations", 1, detailFamily.currFood, 4, 1, .01)
		nk.groupEnd()
		nk.text(detailFamily.description, x + 20, y + 300, 400, 200)
	end
	nk.windowEnd()

	-- Village Overall Menu
	if nk.windowBegin('Village Info', 5, 450, 790, 145, 'border', 'title') then
		nk.layoutRow('dynamic', 790, 3)
		nk.groupBegin('status1')
			nk.layoutRow('dynamic', 30, 1)
			nk.label("Month: "..currMonth)
			nk.label("Revolutionaries: "..revRole.."s")
			nk.label("Reactionaries: "..reactRole.."s")
		nk.groupEnd()
		nk.groupBegin("productionData")
			nk.layoutRow('dynamic', 30, 1)
			nk.label("Production "..currentProd.."kg Steel")
			nk.label("Quota: "..prevProd.."kg Steel")
		nk.groupEnd()
		nk.groupBegin("nextMonth")
			nk.layoutRow('dynamic', 100, 1)
			if nk.button('Next Month') then
				nextMonth()
			end
		nk.groupEnd()
	end
	nk.windowEnd()
	if mistake then
		if nk.windowBegin('Warning', 200, 200, 300, 300, 'border') then
			local x, y, w, h = nk.windowGetBounds()
			if nk.popupBegin('dynamic', "Warning Comrade", x-300, y-200, 600, h, 'title', 'border', 'movable') then
				nk.layoutRow('dynamic', 50, 1)
				nk.label("Comrade, it appears that you have not been distributing food accurately to reward our allies and punish our enemies. If you continue this behaviour, we may need to 'investigate.' -- Comrade Chairman", 'wrap')
				if nk.button('Yes, Comrade!') then
					mistake = false
					nk.popupClose()
				end
			end
			nk.popupEnd()
		end
		nk.windowEnd()
	end
end