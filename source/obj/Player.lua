local Cast = require("../../util/Conversion")
local TimeSpan = require("source/classes/TimeSpan")
local Hitbox = require("source/obj/Hitbox")
local Bullet = require("source/obj/Bullet")

local Player = { _class = "Player" }
Player.__index = Player

Player.name = ""
Player.hitbox = nil
Player.color = {1, 1, 1}

Player.angle = 0
Player.speed = 3

Player.health = 125
Player.ammo = 0

Player.inv = {}
Player.inv_select = 1

Player.shoot_timer = TimeSpan:new(8)
Player.anim = {}
Player.anim.shoot_angle = 0

function Player:new(name, x, y, color, health, ammo)
	local ammo = ammo or 64
	local this = setmetatable({}, self)

	this.name = name
	this.hitbox = Hitbox:new(x, y, 20, 20)
	this.color = color

	this.health = health or self.health
	this.ammo = ammo

	return this
end

function Player:update(dt)
	local mouse_x = love.mouse.getX()
	local mouse_y = love.mouse.getY()
	local key_left = love.keyboard.isDown("a")
	local key_right = love.keyboard.isDown("d")

	self.shoot_timer:update(dt)
	
	if self.anim.shoot_angle > 0 then
		self.anim.shoot_angle = self.anim.shoot_angle - 0.1
	elseif self.anim.shoot_angle < 0 then
		self.anim.shoot_angle = 0
	end
	
	local dir_x = Cast.ToNumber(key_right) - Cast.ToNumber(key_left)
	
	self.hitbox.x = self.hitbox.x + dir_x * self.speed
	self.angle = math.atan2(mouse_y - self.hitbox.y, mouse_x - self.hitbox.x)

	if self.shoot_timer:finished() then
		if love.mouse.isDown(1) and self.ammo > 0 and self.inv[self.inv_select] ~= nil then
			local center_x = self.hitbox:get_center_x()
			local center_y = self.hitbox:get_center_y()
			local joint = assets.joints[self.inv[self.inv_select]]
			local scale_delta = 1

			if mouse_x < self.hitbox.x then
				scale_delta = -1
			end

			self.shoot_timer:reset()
			self.anim.shoot_angle = 1
			world:add( Bullet:new(center_x + joint.shoot_x * 0.2 * scale_delta, self.hitbox.y + joint.shoot_y * 0.2, self.angle, 10, 20) )

			self.ammo = self.ammo - 1
		end
	end
end

function Player:render(debug)
	local mouse_x = love.mouse.getX()
	local mouse_y = love.mouse.getY()
	local center_x = self.hitbox:get_center_x()
	local center_y = self.hitbox:get_center_y()
	local x_dir = math.cos(self.angle)
	local y_dir = math.sin(self.angle)
	
	love.graphics.setColor(self.color)
	love.graphics.rectangle(
		"fill",
		self.hitbox.x, self.hitbox.y,
		self.hitbox.width, self.hitbox.height
	)

	self:render_gun()

	if debug.enabled then
		self.hitbox:render()
		local x = math.cos(self.angle) * debug.dir_length + center_x
		local y = math.sin(self.angle) * debug.dir_length + center_y
		
		love.graphics.line(center_x, center_y, x, y)
	end
end

function Player:render_gun()
	local mouse_x = love.mouse.getX()
	local mouse_y = love.mouse.getY()
	local center_x = self.hitbox:get_center_x()
	local center_y = self.hitbox:get_center_y()
	local x_dir = math.cos(self.angle)
	local y_dir = math.sin(self.angle)
	local scale_delta = 1

	if mouse_x < self.hitbox.x then
		scale_delta = -1
	end

	if self.inv[self.inv_select] == nil then
		return
	end

	love.graphics.setColor({1, 1, 1})
	love.graphics.draw(
		assets[self.inv[self.inv_select]],
		center_x + x_dir * 20, center_y + y_dir * 20,
		self.angle - self.anim.shoot_angle * scale_delta,
		0.2, 0.2 * scale_delta,
		assets.joints[self.inv[self.inv_select]].x,
		assets.joints[self.inv[self.inv_select]].y
	)
end

function Player:on_collide(obj)
	if obj._class == "AmmoBox" then
		self.ammo = self.ammo + obj.ammo
		world:destroy(obj)
	elseif obj._class == "Bullet" then
		self.health = self.health - obj.damage
		world:destroy(obj) -- Just in case if it will do it twice
	end
end

return Player