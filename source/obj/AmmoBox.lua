local OOP = require("../../util/OOP")
local Hitbox = require("source/obj/Hitbox")
-- local Object = require("source/obj/Entity")
local Text = require("source/obj/Text")

return function(x, y, ammo)
	return OOP.class("AmmoBox",
	{
		hitbox = Hitbox(x, y, 10, 10),
		ammo = ammo,

		update = function(self)
		end,

		render = function(self, debug)
			love.graphics.setColor({1, 1, 1})
			love.graphics.rectangle("fill", self.hitbox.x, self.hitbox.y, self.hitbox.width, self.hitbox.height)

			if debug then
				self.hitbox:render()
			end
		end,

		destroy = function(self)
			world:add( Text(tostring(self.ammo), self.hitbox.x, self.hitbox.y, {timer = 0, vel_y = -5}, function(self, dt)
				self.prop.timer = self.prop.timer + 1

				if self.prop.vel_y < 0 then
					self.prop.vel_y = self.prop.vel_y + 0.5
				end
				
				self.hitbox.y = self.hitbox.y + self.prop.vel_y

				if self.prop.timer > 50 then
					world:remove(self)
				end
			end))
		end
	})
end