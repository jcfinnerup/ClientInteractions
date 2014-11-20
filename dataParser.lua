--[[

			This class is meant to parse the data into the JSON format
			with the right sub-formatting as well.
]]

module(...,package.seeall)

print("Loading Data Parser..")

------------------------------------------
--			   Requirements				--
------------------------------------------

local json = require "json"

------------------------------------------
--				Variables				--
------------------------------------------

-- Meeting Format Table
local meetingFormatTable = {
	"name",
	"client",
	"day",
	"month",
	"year",
	"contact",
	"level",
	"business",
	"opp"
}

------------------------------------------
--				Functions				--
------------------------------------------

-- Un Nil
local function unNil(data)
	for i=1, #meetingFormatTable do
		if data[meetingFormatTable[i]] == nil then
			data[meetingFormatTable[i]] = "no data"
		end
	end
end

-- Encode To Meeting Format
function getMeetingDataToSend(dateTable)

	-- This is the data table
	local meetingData = {
		["name"] 					= dateTable["name"],
		["client"] 					= dateTable["client"],
		["day"]						= ""..dateTable["date"][1],
		["month"]					= ""..dateTable["date"][2],
		["year"] 					= ""..dateTable["date"][3],
		["contact"] 				= dateTable["contact"],
		["level"] 					= dateTable["level"],
		["business"] 				= dateTable["business"],
		["opp"] 					= dateTable["opp"]
	}	
	
	unNil(meetingData)
	local stringToSend = json.encode(meetingData)
	return stringToSend
end


