module(..., package.seeall)

--[[
This Module Handles All the in coming and out going connections to and from the server.
Basically: This is the internet stuff Class
]]

print("Loading Connector..")

------------------------------------------
--			   Requirements				--
------------------------------------------

-- Socket Library
local socket = require "socket"

------------------------------------------
--				Variables				--
------------------------------------------

-- THE TCP VARIABLES ARE CREATED IN RESET TCP
-- first function


local ip = "54.76.199.23"

-- Port
local port = 2014

------------------------------------------
--			Display Objects				--
------------------------------------------


------------------------------------------
--				Functions				--
------------------------------------------

-- Reset TCP Socket
local function resetTCP()
	tcp = nil;
	tcp = socket.tcp()
	tcp:settimeout(4)
end
resetTCP()

-- Error Printer
local function cantConnect()
	print("Cannot Connect to Server")
end

-- Push Question To Server
function pushToServer(dataToSend)
	local serverReply = "Error"
	
	-- Safe Function (xpcall)
	local function performConnect()
		tcp:connect(ip, port)
		tcp:send(dataToSend)
		tcp:shutdown("send")
		serverReply = tcp:receive("*l")
		tcp:close()
		resetTCP()
		
		if serverReply == nil then
			serverReply = "noconnect"
		end
	end
	xpcall(performConnect, cantConnect)
		
	return serverReply;
end

