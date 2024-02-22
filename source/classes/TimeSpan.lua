local OOP = require("../../util/OOP")

return function(max, inc, loop)
	return OOP.class("TimeSpan",
	{
		value = 0,
		max = max,
		inc = inc or 1,
		loop = loop or false,

		update = function(self, dt)
			if self.value <= self.max then
				self.value = self.value + 1
			end
			
			if self.value > self.max and self.loop then
				self.reset()
			end
		end,

		reset = function(self)
			self.value = 0
		end,

		finished = function(self)
			return self.value > self.max
		end
	})
end