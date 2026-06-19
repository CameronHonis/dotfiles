--!strict
export type function Exclude(unionType: type, excludeType: type)
	if unionType.tag == "table" then
		local result = types.newtable()

		for key, prop in unionType:properties() do
			local shouldExclude = false

			if excludeType:is("singleton") and typeof(excludeType:value()) == "string" then
				if key:is("singleton") and key:value() == excludeType:value() then
					shouldExclude = true
				end
			elseif prop.read == excludeType then
				shouldExclude = true
			end
			if not shouldExclude then
				if prop.read ~= prop.write then
					result:setreadproperty(key, prop.read)
					result:setwriteproperty(key, prop.write)
				else
					result:setproperty(key, prop.read)
				end
			end
		end

		return result
	end

	if unionType.tag ~= "union" then
		return unionType == excludeType and types.never or unionType
	end

	local remaining = {}
	for _, component in unionType:components() do
		if component ~= excludeType then
			table.insert(remaining, component)
		end
	end

	if #remaining == 0 then
		return types.never
	elseif #remaining == 1 then
		return remaining[1]
	else
		return types.unionof(unpack(remaining))
	end
end

type TestType = {
	a: string,
	b: number,
	c: boolean,
}

local a: Exclude<{ a: string, b: number }, "b"> = { a = "asdf" }
print(a)
