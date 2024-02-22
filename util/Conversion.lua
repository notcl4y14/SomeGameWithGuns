local Conversion = {}

Conversion.ToNumber = function(value)
	if type(value) == "boolean" then
		if value == true then
			return 1
		elseif value == false then
			return 0
		end
	end

	return tonumber(value)
end

return Conversion