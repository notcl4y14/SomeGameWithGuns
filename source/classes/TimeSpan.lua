local TimeSpan = { _class = "TimeSpan" }
TimeSpan.__index = TimeSpan

TimeSpan.value = 0
TimeSpan.max = 0
TimeSpan.inc = 1
TimeSpan.loop = false

function TimeSpan:new(max, inc, loop)
	local this = setmetatable({}, self)

	this.max = max
	this.inc = inc or self.inc
	this.loop = loop or self.loop

	return this
end

function TimeSpan:reset()
	self.value = 0
end

function TimeSpan:finished()
	return self.value > self.max
end

function TimeSpan:update(dt)
	if self.value <= self.max then
		self.value = self.value + 1
	end
	
	if self.value > self.max and self.loop then
		self.reset()
	end
end

return TimeSpan