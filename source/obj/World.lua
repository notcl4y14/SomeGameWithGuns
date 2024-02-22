local OOP = require("../../util/OOP")

return function()
	return OOP.class("World",
	{
		objects = {},

		update = function(self, dt)
			for _, obj in pairs(self.objects) do
				if obj.update then
					obj:update(dt)
				else
					print("Warning: Object '" .. OOP.getClass(obj) .. "' does not have an update function")
				end
			end
		end,

		render = function(self, hitbox)
			local hitbox = hitbox or false

			for _, obj in pairs(self.objects) do
				if obj.render then
					obj:render(hitbox)
				else
					print("Warning: Object '" .. OOP.getClass(obj) .. "' does not have a render function")
				end
			end
		end,

		add = function(self, obj)
			table.insert(self.objects, obj)
		end
	})
end