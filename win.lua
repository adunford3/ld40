-- required modules
local nk = require 'nuklear'
Object = require "lib.classic"
require "family"
require "dataController"

-- Global variables

return function()
	if nk.windowBegin('winScreen', 200, 100, 300, 400, 'border') then
		local x, y, w, h = nk.windowGetBounds()
		nk.layoutRow('dynamic', 200, 1)
		nk.label("Congratulations Comrade!
			You have succeeded where so many others have failed! Leading a village in the name of the People is no easy task, but you have shown your true strength as a Comrade of the People. Comrade Distributor, well done.

			I look forward to seeing your continued efforts in pushing our great country to an even greater future!
			-- Comrade Chairman", 'wrap')
		if nk.button("Main Menu") then
			gamestate = "startMenu"
		end
	end
	nk.windowEnd()
end