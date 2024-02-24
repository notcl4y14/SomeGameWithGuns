local Hitbox = require("source/obj/Hitbox")
local Text = require("source/obj/Text")

local AmmoBox = { _class = "AmmoBox" }
AmmoBox.__index = AmmoBox

AmmoBox.hitbox = nil
AmmoBox.ammo = 0

function AmmoBox:new(x, y, ammo)
	local this = setmetatable({}, self)

	this.hitbox = Hitbox:new(x, y, 10, 5, 0)
	this.ammo = ammo

	return this
end

function AmmoBox:destroy()
	local text = Text:new(tostring(self.ammo), self.hitbox.x, self.hitbox.y)
	text._timer = 0
	text._vel_y = -10
	
	text.update = function(self, dt)
		self._timer = self._timer + 1

		if self._vel_y < 0 then
			self._vel_y = self._vel_y + 1
		end
		
		self.hitbox.y = self.hitbox.y + self._vel_y

		if self._timer > 40 then
			world:remove(self)
		end
	end

	world:add(text)
end

function AmmoBox:update(dt)
end

function AmmoBox:render(debug)
	love.graphics.setColor({1, 1, 1})
	love.graphics.rectangle("fill", self.hitbox.x, self.hitbox.y, self.hitbox.width, self.hitbox.height)

	if debug then
		self.hitbox:render()
	end
end

return AmmoBox