local DBHandler=nil
local DBName="stegna_user"
local DBUser="stegna_user"
local DBPass="OkB00mer"
local DBHost="okB00mer"

function dbSet(...)
	if not {...} then return end
	query=dbExec(DBHandler, ...)
	return query
end

function dbGet(...)
	if not {...} then return end
	query=dbQuery(DBHandler, ...)
	result=dbPoll(query, -1)
	return result
end

addEventHandler("onResourceStart", resourceRoot, function()
	DBHandler=dbConnect("mysql", "dbname="..DBName..";host="..DBHost.."", DBUser, DBPass, "share=1")
	if DBHandler then
		outputDebugString("m_mysql | Connected to mysql")
	else
		outputDebugString("m_mysql | Can't connect  to mysql")
	end
end)
