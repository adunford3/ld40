-- required modules
local nk = require 'nuklear'
Object = require "lib.classic"
require "family"
require "dataController"

-- Global variables

return function()
	if nk.windowBegin('You lose', 200, 100, 300, 400, 'border', 'title') then
		local x, y, w, h = nk.windowGetBounds()
		nk.layoutRow('dynamic', 200, 1)
		nk.label("Comrade, I fear that your inability to lead your village has given me no choice but to remove you from your position. Additionally, reports of your support of despicable reactionaries has reached my desk. You know what this means. -- Comrade Chairman", 'wrap')
		if nk.button("Main Menu") then
			gamestate = "startMenu"
		end
	end
	nk.windowEnd()
end