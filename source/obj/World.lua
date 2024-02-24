-- local OOP = require("../../util/OOP")
local World = { _class = "World" }
World.__index = World

World.objects = {}

function World:new()
	local this = setmetatable({}, self)
	return this
end

function World:add(obj)
	table.insert(self.objects, obj)
end

function World:search(obj)
	for key, value in pairs(self.objects) do
		if value == obj then
			return obj, key
		end
	end

	return nil, nil
end

function World:remove(obj)
	local _, key = self:search(obj)

	if not key then
		return
	end
	
	table.remove(self.objects, key)
end

function World:destroy(obj)
	local obj, key = self:search(obj)

	if not key then
		return
	end

	if obj.destroy then
		obj:destroy()
	end

	table.remove(self.objects, key)
end

function World:update(dt)
	for _, obj in pairs(self.objects) do
		if obj.update then
			obj:update(dt)
		else
			print("Warning: Object '" .. OOP.getClass(obj) .. "' does not have an update function")
		end

		for _, obj2 in pairs(self.objects) do
			if obj ~= obj2 and obj.hitbox:collides(obj2.hitbox) and obj.on_collide then
				obj:on_collide(obj2)
			end
		end
	end
end

function World:render(hitbox)
	local hitbox = hitbox or false

	for _, obj in pairs(self.objects) do
		if obj.render then
			obj:render(hitbox)
		else
			print("Warning: Object '" .. OOP.getClass(obj) .. "' does not have a render function")
		end
	end
end

return World