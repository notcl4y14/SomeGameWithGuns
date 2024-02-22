local Color = require("source/Color")
local OOP = require("../../util/OOP")

return function(x, y, width, height)
	return OOP.class("Hitbox",
	{
		x = x,
		y = y,
		width = width,
		height = height,

		render = function(self, color, mode)
			local color = color or Color.WHITE
			local mode = mode or "line"

			love.graphics.setColor(color)
			love.graphics.rectangle(
				mode,
				self.x, self.y,
				self.width, self.height
			)
		end,

		getCenterX = function(self)
			return self.x + (self.width / 2)
		end,

		getCenterY = function(self)
			return self.y + (self.height / 2)
		end
	})
end