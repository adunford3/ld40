local pRoles = require "data.pRoles"
local cRoles = require "data.cRoles"
local names = require 'data.names'
require "family"

prevMonth = nil
currMonth = nil
revRole = nil
reactRole = nil
prevProd = nil
quota = nil
currentProd = nil
totalFood = nil
mistake = nil
numMistakes = nil

function dataInit() 
	prevMonth = 0
	currMonth = 1
	revRole = revRoles()
	reactRole = reactRoles()
	prevProd = 200
	currentProd = calculateProd()
	mistake = false
	numMistakes = 0
end

function nextMonth()
	prevmonth = currMonth
	currMonth = currMonth + 1
	revRole = revRoles()
	reactRole = reactRoles()
	prevProd = currentProd
	--currentProd = calculateProd()
	calculateHunger()
	calculateDeath()
	mistake = checkRoles()
	checkMistake()
	checkWin()
end

function revRoles()
	local role = cRoles[math.random(9)]
	return role
end

function reactRoles()
	local role = cRoles[math.random(9)]
	while role == revRole do
		role = cRoles[math.random(9)]
	end
	return role
end

function calculateHunger()
	for i=1,famLength do
		fam = families[i]
		fam.lastFood = fam.currFood
		if fam.lastFood >= 3 then
			fam.hungry = false
			fam.starving = false
			fam.status = "Good"
		elseif fam.lastFood == 2 then
			fam.hungry = true
			fam.starving = false
			fam.status = "Hungry"
		elseif fam.lastFood == 1 then
			fam.hungry = false
			fam.starving = true
			fam.status = "Starving"
		end
	end
end

function calculateDeath()
	for i=famLength,1,-1 do
		local fam = families[i]
		if fam.starving then
			fam.famSize = fam.famSize - 1
			if fam.famSize < 1 then
				table.remove(families, i)
				famLength = famLength - 1
				print(famLength)
			end
		end
	end
end

function updateFamProd(fam)
	if fam.currFood == 4 then
		fam.production = 1
	elseif fam.currFood == 3 then
		fam.production = .75
	elseif fam.currFood == 2 then
		fam.production = .25
	elseif fam.currFood == 1 then
		fam.production = 0
	end
end

function calculateFamProd(fam)
	updateFamProd(fam)
	local famProd = fam.famSize * fam.production * 10
	return famProd
end

function calculateProd()
	local totalProd = 0
	for i=1,famLength do
		local fam = families[i]
		totalProd = totalProd + calculateFamProd(fam)
	end
	return totalProd
end

function checkRoles()
	for i=1,famLength do
		local fam = families[i]
		if checkReactRoles(fam) == true or checkRevRoles(fam) == true then
			numMistakes = numMistakes + 1
			return true
		end
		return false
	end 
end

function checkReactRoles(fam)
	--todo: check the current good/bad roles for proper rations, add popup if incorrect
	if fam.prRole == reactRole and fam.cRole == reactRole and fam.lastFood > 1 then
		return true
	elseif (fam.prRole == reactRole or fam.cRole == reactRole)  and fam.lastFood > 2 then
		return true
	end
	return false
end

function checkRevRoles(fam)
	if (fam.prRole == revRole or fam.cRole == revRole) and fam.lastFood < 4 then
		return true
	elseif fam.prRole ~= reactRole and fam.cRole ~= reactRole and fam.prRole ~= revRole and fam.cRole ~= revRole and fam.lastFood ~= 3 then
		return true
	end
	return false
end

function checkMistake() 
	if numMistakes > 2 then
		gamestate = 'lose'
	end
	if currentProd < prevProd then
		gamestate = 'lose'
	end
end

function checkWin()
	if currMonth == 13 then
		gamestate = 'win'
	end
end