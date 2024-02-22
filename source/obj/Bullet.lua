local OOP = require("../../util/OOP")
local Cast = require("../../util/Conversion")
local Hitbox = require("source/obj/Hitbox")

return function(x, y, angle, speed)
	return OOP.class("Player",
	{
		-- _class = "Player",
		
		hitbox = Hitbox(x, y, 10, 5),
		angle = angle,
		speed = speed,

		update = function(self, dt)
			local x_dir = math.cos(self.angle)
			local y_dir = math.sin(self.angle)

			self.hitbox.x = self.hitbox.x + x_dir * self.speed
			self.hitbox.y = self.hitbox.y + y_dir * self.speed
		end,

		render = function(self, debug)
			local center_x = self.hitbox:getCenterX()
			local center_y = self.hitbox:getCenterY()
			local x_dir = math.cos(self.angle)
			local y_dir = math.sin(self.angle)
			local length = 10

			love.graphics.setColor({1, 1, 1})
			love.graphics.line(
				self.hitbox.x,
				center_y,
				self.hitbox.x + x_dir * length,
				center_y + y_dir * length
			)

			if debug.enabled then
				self.hitbox:render()
				local x = math.cos(self.angle) * debug.dir_length + center_x
				local y = math.sin(self.angle) * debug.dir_length + center_y
				
				love.graphics.line(center_x, center_y, x, y)
			end
		end
	})
end