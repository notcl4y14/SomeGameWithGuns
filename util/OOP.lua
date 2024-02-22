local OOP = {}

OOP.class = function(type, _obj)
	local obj = {_class = type}

	for key, value in pairs(_obj) do
		if key == "_class" then
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