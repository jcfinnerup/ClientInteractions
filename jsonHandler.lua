
module(...,package.seeall)
print("JSON: Starting..")

--==========================================--
--==========================================--
--               JSON HANDLER               --
--==========================================--
--==========================================--

-- Require JSON
local json = require "json"

-- JSON FILE VARIABLES (To call)


local dataPath = system.pathForFile( "data2.json", system.DocumentsDirectory )
local file1 = io.open( dataPath, "r" )

local data

if not file1  then
    print("JSON: data.json missing! Creating new file..")

    local deployPath1 = system.pathForFile("JSON/data.json", system.ResourceDirectory)
    local file1 = io.open( deployPath1, "r" )
    local saveData1 = file1:read( "*a" )
    io.close( file1 )
	
    --- Write JSON content into SANDBOX file
    file1 = io.open( dataPath, "w")
    file1:write( saveData1 )
    io.close( file1 )
    file1 = nil
    
    data   =  json.decode( saveData1 )
	
else
    print("JSON: data.json found!")
	-- read all contents of file into a string
	local saveData1 = file1:read( "*a" )
	    
    -- Saving data in local variables
    data = json.decode( saveData1 )

    -- close the file after using it
	io.close( file1 )
end

--==========================================--
--         		READ FUNCTIONS        		--
--==========================================--

function getName()
    local name
   	name = data["name"]
    return name    
end


function getMeetings()
    local meetings
   	meetings = data["meetings"]
    return meetings    
end

function getAllInteractions()
    local interactions
   	interactions = data["allInteractions"]
    return interactions    
end


--==========================================--
--         		WRITE FUNCTIONS        		--
--==========================================--

function setName(newName)
    data["name"] = newName
	local file = io.open( dataPath, "w")
	file:write( json.encode(data) )
	io.close( file )
	file = nil
end

function setMeetings()
    local meetings = data["meetings"] 
    data["meetings"] = meetings+1
	local file = io.open( dataPath, "w")
	file:write( json.encode(data) )
	io.close( file )
	file = nil
end

function addNewInteraction(newInteraction)
	table.insert( data["allInteractions"], newInteraction )
	local file = io.open( dataPath, "w")
	file:write( json.encode(data) )
	io.close( file )
	file = nil
end

