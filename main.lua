local lg = love.graphics
local Color = require("source/Color")
local World = require("source/obj/World")
local Player = require("source/obj/Player")
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

	world = World()
	world:add( Player("Player01", 20, 70, Color.BLUE) )
	world:add( AmmoBox(80, 70, 100))
end

function love.update(dt)
	world:update(dt)
end

function love.draw()
	lg.clear(Color.DARK_BLUE)
	world:render(debug)

	lg.print("Ammo: " .. world.objects[1].ammo, 10, lg.getHeight() - (10 + 14))

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