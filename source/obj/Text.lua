local OOP = require("../../util/OOP")
local Hitbox = require("source/obj/Hitbox")

return function(text, x, y, prop, update)
	return OOP.class("Text",
	{
		hitbox = Hitbox(x, y, #text * 6, 14),
		text = text,
		prop = prop,

		update = update or function(self, dt)
		end,

		render = function(self, debug)
			love.graphics.print(self.text, self.hitbox.x, self.hitbox.y)
		end
	})
end