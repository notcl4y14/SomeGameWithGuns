local OOP = {}

OOP.class = function(type, _obj, extend)
	local extend = extend or {}
	local obj = {_class = type, _extend = OOP.getClass(extend)}

	for key, value in pairs(extend) do
		obj[key] = value
	end

	for key, value in pairs(_obj) do
		if key == "_class" or key == "_extend" then
			error("Cannot override class properties of an object")
		end

		obj[key] = value
	end

	return obj
end

OOP.getClass = function(obj)
	return obj._class
end

return OOP