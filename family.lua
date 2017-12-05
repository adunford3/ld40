local pRoles = require "data.pRoles"
local cRoles = require "data.cRoles"
local names = require "data.names"
local image = love.graphics.newImage("img/template1.png") -- temporary, will load and generate images at another point

Family = Object:extend()

function Family.new(self)
	self.name = names[math.random(20)]
	self.prRole = pRoles[math.random(6)]
	self.cRole = cRoles[math.random(9)]
	self.image = image
	self.famSize = math.random(1,6)
	self.lastFood = 4
	self.currFood = 4
	self.hungry = false
	self.starving = false
	self.production = 1
	self.status = "Good"
	self.description = "Family descriptions will be implemented at a later time."
end