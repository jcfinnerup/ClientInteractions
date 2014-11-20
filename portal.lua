module(..., package.seeall)


----------------------------------
--		Requirements			--
----------------------------------

-- Data Parser
dataParser = require "dataParser"

-- Connector 
connector = require "connector"

----------------------------------
--		Server Connection		--
----------------------------------

-- Register Meeting
function registerMeeting(inputData)
	print("Sending to server..")
	local dataToSend = dataParser.getMeetingDataToSend(inputData);
	local serverReply = connector.pushToServer(dataToSend)
	print(serverReply)
	return serverReply
end