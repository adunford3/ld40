-- Libraries used
Object = require "lib.classic"
local lume = require "lib.lume"
local nk = require "nuklear"
local style = require 'style'
music1 = love.audio.newSource("sound/Distributor_Gameplay.wav")

-- Other game files
require 'dataController'

-- Global variables

-- local variables


function love.load()
	math.randomseed( tonumber(tostring(os.time()):reverse():sub(1,6)) ) -- generate more random numbers each time the game is loaded

	love.keyboard.setKeyRepeat(true)
	nk.init()

	gamestate = "startMenu"
	families = {}
	famLength = 0
	
	require "family"
	generateFamilies()

	dataInit()

	-- require "img.template1" -- load all images ahead of time
	-- images = {}

	startMenu = require 'startMenu'
	game = require 'game'
	lose = require 'lose'
	win = require 'win'
end

function love.update(dt)
	if gamestate == "startMenu" then
		nk.frameBegin()
		style()
		startMenu()
		dataInit()
		nk.frameEnd()
	elseif gamestate == "game" then
		music1:play()
		nk.frameBegin()
		game()
		nk.frameEnd()
	elseif gamestate == "lose" then
		nk.frameBegin()
		lose()
		nk.frameEnd()
	elseif gamestate == "win" then
		nk.frameBegin()
		win()
		nk.frameEnd()
	end
end

function love.draw()
	nk.draw()
end

function generateFamilies()
	famLength = 10
	for i=1,famLength do
		fam = Family()
		families[i] = fam
	end
end

function loadImages()
	-- TODO: make at least 10 images to pick from and change file names so can be added to families manually
end

function love.keypressed(key, scancode, isrepeat)
	if nk.keypressed(key, scancode, isrepeat) then
		return -- event consumed
	end
end

function love.keyreleased(key, scancode)
	if nk.keyreleased(key, scancode) then
		return -- event consumed
	end
end

function love.mousepressed(x, y, button, istouch)
	if nk.mousepressed(x, y, button, istouch) then
		return -- event consumed
	end
end

function love.mousereleased(x, y, button, istouch)
	if nk.mousereleased(x, y, button, istouch) then
		return -- event consumed
	end
end

function love.mousemoved(x, y, dx, dy, istouch)
	if nk.mousemoved(x, y, dx, dy, istouch) then
		return -- event consumed
	end
end

function love.textinput(text)
	if nk.textinput(text) then
		return -- event consumed
	end
end

function love.wheelmoved(x, y)
	if nk.wheelmoved(x, y) then
		return -- event consumed
	end
end