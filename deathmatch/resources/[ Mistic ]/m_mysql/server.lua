base = nil -- Do not touch this

local SETTINGS = {
	"misticmta_name", -- User
	"misticmta_user", -- Name
	"misticmta_password", -- Password
	"misticmta_host" -- Host
	"share=1" -- Can be used for Sharing ( Data Base ) [share]
}

function dbGet(...)
    if not {...} then return end
	query = dbQuery(base, ...) -- Database query
	result = dbPoll(query, -1) -- Data query procedure
	return result
end

function checkConnect(resource)
	local rName = getResourceName(resource)
	base = dbConnect("mysql", "dbname="..SETTINGS[1]..";host="..SETTINGS[4].."", SETTINGS[2], SETTINGS[3], SETTINGS[5])
	if base then
		print(rName.." | Connected to mysql")
	else
		print(rName.." | Connection closed")
	end
end
addEventHandler("onResourceStart", resourceRoot, checkConnect)
