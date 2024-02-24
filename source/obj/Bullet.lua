local Cast = require("../../util/Conversion")
local Hitbox = require("source/obj/Hitbox")

local Bullet = { _class = "Bullet" }
Bullet.__index = Bullet

Bullet.hitbox = nil
Bullet.damage = 0
Bullet.speed = 0
Bullet.length = 0

function Bullet:new(x, y, angle, damage, speed, length)
	local this = setmetatable({}, self)

	this.hitbox = Hitbox:new(x, y, 10, 5, angle)
	this.damage = damage
	this.speed = speed
	this.length = length or 30

	return this
end

function Bullet:on_collide(obj)
	-- if obj._tags["solid"] ~= nil or obj._class == "Player" then
	if obj._class == "Player" then
		obj:on_collide(self) -- Just in case if the game won't notice the deleted object
		world:destroy(self)
	end
end

function Bullet:update(dt)
	local x_dir = math.cos(self.hitbox.angle)
	local y_dir = math.sin(self.hitbox.angle)

	self.hitbox.x = self.hitbox.x + x_dir * self.speed
	self.hitbox.y = self.hitbox.y + y_dir * self.speed
end

function Bullet:render(debug)
	local center_x = self.hitbox:get_center_x()
	local center_y = self.hitbox:get_center_y()
	local x_dir = math.cos(self.hitbox.angle)
	local y_dir = math.sin(self.hitbox.angle)

	love.graphics.setColor({1, 1, 1})
	love.graphics.line(
		self.hitbox.x,
		center_y,
		self.hitbox.x + x_dir * self.length,
		center_y + y_dir * self.length
	)

	if debug.enabled then
		self.hitbox:render()
		local x = math.cos(self.hitbox.angle) * debug.dir_length + center_x
		local y = math.sin(self.hitbox.angle) * debug.dir_length + center_y
		
		love.graphics.line(center_x, center_y, x, y)
	end
end

return Bullet