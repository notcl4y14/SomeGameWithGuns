local Hitbox = require("source/obj/Hitbox")

local Text = { _class = "Text" }
Text.__index = Text

Text.text = ""
Text.hitbox = nil

function Text:new(text, x, y)
	local this = setmetatable({}, self)

	this.text = text
	this.hitbox = Hitbox:new(x, y, #text * 6, 14)

	return this
end

function Text:update(dt)
end

function Text:render(debug)
	love.graphics.print(self.text, self.hitbox.x, self.hitbox.y)
end

return Text