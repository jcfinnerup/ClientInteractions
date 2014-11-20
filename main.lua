-------------------------------
		 -- MAIN --
-------------------------------

-- Director
director = require "director";

-- Json Handler
jsonHandler = require "jsonHandler"

-- Navigator
navigator = require "navigator"

-- Portal
portal = require "portal"


--------------------------------------
-- 				Variables			--
--------------------------------------
localTime = os.date( '*t' )
localDate = os.date( "*t" )


-- MAIN GROUO
local mainGroup = display.newGroup();

-- MAIN FUNCTION
local function main()
	mainGroup:insert(director.directorView);
	-- WHERE TO GO FIRST
	director:changeScene("menu");
	native.showAlert( "Important", "Accenture wifi is still blocking this App. Please use a 3G connection when using it" , {"Noted"} )
	
	
	return true;
end
main();
