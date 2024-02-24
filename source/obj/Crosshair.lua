local Hitbox = require("source/obj/Hitbox")

local Crosshair = { _class = "Crosshair" }
Crosshair.__index = Crosshair

Crosshair.hitbox = nil
Crosshair.img = nil

function Crosshair:new(img)
	local this = setmetatable({}, self)

	this.hitbox = Hitbox:new(0, 0, img:getWidth(), img:getHeight(), 0)
	this.img = img

	return this
end

function Crosshair:update(dt)
	self.hitbox.x = love.mouse.getX() - (self.hitbox.width / 2)
	self.hitbox.y = love.mouse.getY() - (self.hitbox.height / 2)
end

function Crosshair:render(debug)
	love.graphics.setColor({1, 1, 1})
	-- love.graphics.rectangle("fill", self.hitbox.x, self.hitbox.y, self.hitbox.width, self.hitbox.height)
	love.graphics.draw(self.img, self.hitbox.x, self.hitbox.y)

	if debug then
		-- self.hitbox:render()
	end
end

return Crosshair