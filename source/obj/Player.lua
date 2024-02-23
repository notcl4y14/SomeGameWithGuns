local OOP = require("../../util/OOP")
local Cast = require("../../util/Conversion")
local TimeSpan = require("source/classes/TimeSpan")
local Hitbox = require("source/obj/Hitbox")
local Bullet = require("source/obj/Bullet")

return function(name, x, y, color)
	return OOP.class("Player",
	{
		-- _class = "Player",
		
		name = name,
		hitbox = Hitbox(x, y, 20, 20),
		color = color,

		look_dir = 0,
		speed = 3,
		
		inv = { "glock" },
		inv_item = 1,
		ammo = 64,

		shoot_timespan = TimeSpan(8),
		anim_shoot_angle = 0,

		update = function(self, dt)
			local mouse_x = love.mouse.getX()
			local mouse_y = love.mouse.getY()
			local key_left = love.keyboard.isDown("a")
			local key_right = love.keyboard.isDown("d")

			self.shoot_timespan:update(dt)
			
			if self.anim_shoot_angle > 0 then
				self.anim_shoot_angle = self.anim_shoot_angle - 0.1
			elseif self.anim_shoot_angle < 0 then
				self.anim_shoot_angle = 0
			end
			
			local dir_x = Cast.ToNumber(key_right) - Cast.ToNumber(key_left)
			
			self.hitbox.x = self.hitbox.x + dir_x * self.speed
			self.look_dir = math.atan2(mouse_y - self.hitbox.y, mouse_x - self.hitbox.x)
			-- print(self.look_dir)

			if self.shoot_timespan:finished() then
				if love.mouse.isDown(1) and self.ammo > 0 then
					local center_x = self.hitbox:getCenterX()
					local center_y = self.hitbox:getCenterY()
					local joint = assets.joints[self.inv[self.inv_item]]
					local scale_delta = 1
		
					if mouse_x < self.hitbox.x then
						scale_delta = -1
					end

					self.shoot_timespan:reset()
					self.anim_shoot_angle = 1
					world:add( Bullet(center_x + joint.shoot_x * 0.2 * scale_delta, self.hitbox.y + joint.shoot_y * 0.2, self.look_dir, 20) )

					self.ammo = self.ammo - 1
				end
			end
		end,

		render = function(self, debug)
			local mouse_x = love.mouse.getX()
			local mouse_y = love.mouse.getY()
			local center_x = self.hitbox:getCenterX()
			local center_y = self.hitbox:getCenterY()
			local x_dir = math.cos(self.look_dir)
			local y_dir = math.sin(self.look_dir)
			local scale_delta = 1

			if mouse_x < self.hitbox.x then
				scale_delta = -1
			end
			
			love.graphics.setColor(self.color)
			love.graphics.rectangle(
				"fill",
				self.hitbox.x, self.hitbox.y,
				self.hitbox.width, self.hitbox.height
			)

			love.graphics.setColor({1, 1, 1})
			love.graphics.draw(
				assets[self.inv[self.inv_item]],
				center_x + x_dir * 20, center_y + y_dir * 20,
				self.look_dir - self.anim_shoot_angle * scale_delta,
				0.2, 0.2 * scale_delta,
				assets.joints[self.inv[self.inv_item]].x,
				assets.joints[self.inv[self.inv_item]].y
			)

			if debug.enabled then
				self.hitbox:render()
				local x = math.cos(self.look_dir) * debug.dir_length + center_x
				local y = math.sin(self.look_dir) * debug.dir_length + center_y
				
				love.graphics.line(center_x, center_y, x, y)
			end
		end,

		collides = function(self, obj)
			if OOP.getClass(obj) == "AmmoBox" then
				self.ammo = self.ammo + obj.ammo

				if obj.destroy then
					obj:destroy()
				end
				
				world:remove(obj)
			end
		end
	})
end