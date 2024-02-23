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
		end,

		collides = function(self, obj)
			local x1, y1, w1, h1 = self.x, self.y, self.width, self.height
			local x2, y2, w2, h2 = obj.x, obj.y, obj.width, obj.height
			
			return x1 < x2+w2 and
				x2 < x1+w1 and
				y1 < y2+h2 and
				y2 < y1+h1
		end
	})
end