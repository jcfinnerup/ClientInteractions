module(..., package.seeall)

function new()

	local localGroup = display.newGroup()

-------------- ABOVE DIRECTOR -------------
print("Loading Menu..")

------------------------------------------
--			   Requirements				--
------------------------------------------
-- Connector
local connector = require "connector"

-- Widget
local widget = require "widget"

------------------------------------------
--				Variables				--
------------------------------------------

------------------------------------------
--			Display Objects				--
------------------------------------------

-- Background
local background = display.newImageRect("images/menuBackground.png", 640, 1136)
background.x, background.y = display.contentCenterX, display.contentCenterY
localGroup:insert(background)

-- Personal Details Button
local personalDetailsBTN = display.newImage("images/personalDetails.png")
personalDetailsBTN:translate(0, display.contentHeight-personalDetailsBTN.height)
personalDetailsBTN.isVisible = false
localGroup:insert(personalDetailsBTN)

-- Add Meeting BTN
local addMeetingBTN = display.newImage("images/addMeeting.png")
addMeetingBTN.x, addMeetingBTN.y = display.contentCenterX, display.contentHeight/3
localGroup:insert(addMeetingBTN)

-- Interactions
local interactionsText = display.newText("Interactions registered: "..jsonHandler.getMeetings(), 0, 0, native.systemFont,30)
localGroup:insert(interactionsText)
interactionsText.x, interactionsText.y = display.contentCenterX, display.contentHeight*0.45

-- Meeting List BTN
local meetingListBTN = display.newImage("images/myInteractionsBTN.png");
meetingListBTN.x, meetingListBTN.y = display.contentCenterX, display.contentHeight-meetingListBTN.height*.5
localGroup:insert(meetingListBTN)

------------------------------------------
--				Functions				--
------------------------------------------

-- Add Meeting
local function addMeeting(e)
	if e.phase == "began" then
		display.getCurrentStage():setFocus(e.target)
		e.target.alpha = 0.5
	elseif e.phase == "ended" then
		e.target.alpha = 1
		display.getCurrentStage():setFocus(nil)
		navigator.goToListView()
	end
end
addMeetingBTN:addEventListener("touch", addMeeting)


-- Add Personal Details
local function addPersonalDetails(e)
	if e.phase == "began" then
		display.getCurrentStage():setFocus(e.target)
		e.target.alpha = 0.5
	elseif e.phase == "ended" then
		e.target.alpha = 1
		display.getCurrentStage():setFocus(nil)
	end
end
personalDetailsBTN:addEventListener("touch", addPersonalDetails)

-- My Interactions
local function goMyInteractions(e)
	if e.phase == "began" then
		display.getCurrentStage():setFocus(e.target)
		e.target.alpha = 0.8
	elseif e.phase == "ended" then
		display.getCurrentStage():setFocus(nil)
		e.target.alpha = 1
		director:changeScene("meetingList", "moveFromRight")
	end
end
meetingListBTN:addEventListener("touch", goMyInteractions)


-------------- BELOW DIRECTOR -------------
	return localGroup
end