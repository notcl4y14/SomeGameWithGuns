local lg = love.graphics
local Color = require("source/Color")
local World = require("source/obj/World")
local Crosshair = require("source/obj/Crosshair")
local Player = require("source/obj/Player")
local Bullet = require("source/obj/Bullet")
local AmmoBox = require("source/obj/AmmoBox")

function love.load()
	debug = {
		enabled = true,
		fps_enabled = true,
		dir_length = 20
	}

	assets = {
		joints = require("assets/joints"),
		glock = lg.newImage("assets/glock.png")
	}

	world = World:new()
	world:add( Player:new("Player01", 20, 70, Color.BLUE) )
	world:add( Player:new("Player02", 400, 70, Color.GREEN) )
	world:add( AmmoBox:new(80, 70, 100))
	world:add( Bullet:new(100, 70, -3.25, 10, 1) )
	world:add( Crosshair:new(love.graphics.newImage("assets/crosshair01.png")) )

	world.objects[1].inv = { "glock" }
	world.objects[2].inv = { "glock" }
end

function love.update(dt)
	world:update(dt)
end

function love.draw()
	lg.clear(Color.DARK_BLUE)
	world:render(debug)

	lg.print("Ammo: " .. world.objects[1].ammo, 10, lg.getHeight() - (10 + 14))
	lg.print("Health: " .. world.objects[1].health, 10, lg.getHeight() - (10 + 14 * 2))

	if debug.fps_enabled then
		lg.print("FPS: " .. love.timer.getFPS())
	end
end

function love.keypressed(key)
	if love.keyboard.isDown("lshift") and key == "f7" then
		debug.enabled = not debug.enabled
	end

	if key == "f3" then
		debug.fps_enabled = not debug.fps_enabled
	end
end

function love.errhand(error)
	love.window.showMessageBox("Lua runtime error", error, "error")
end