local Color = require("source/Color")

local Hitbox = { _class = "Hitbox" }
Hitbox.__index = Hitbox

Hitbox.x = 0
Hitbox.y = 0
Hitbox.width = 0
Hitbox.height = 0
Hitbox.angle = 0

function Hitbox:new(x, y, width, height, angle)
	local this = setmetatable({}, self)

	this.x = x
	this.y = y
	this.width = width
	this.height = height
	this.angle = angle or 0

	return this
end

function Hitbox:get_center_x()
	return self.x + (self.width / 2)
end

function Hitbox:get_center_y()
	return self.y + (self.height / 2)
end

function Hitbox:collides(hitbox)
	local x1, y1, w1, h1 = self.x, self.y, self.width, self.height
	local x2, y2, w2, h2 = hitbox.x, hitbox.y, hitbox.width, hitbox.height
	
	return x1 < x2+w2 and
		x2 < x1+w1 and
		y1 < y2+h2 and
		y2 < y1+h1
end

function Hitbox:update(dt)
end

function Hitbox:render(color, mode)
	local color = color or Color.WHITE
	local mode = mode or "line"

	love.graphics.setColor(color)
	love.graphics.rectangle(
		mode,
		self.x, self.y,
		self.width, self.height
	)
end

return Hitbox