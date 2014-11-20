module(..., package.seeall)

function new()

	local localGroup = display.newGroup()

-------------- ABOVE DIRECTOR -------------
print("Loading List View..")

------------------------------------------
--			   Requirements				--
------------------------------------------

-- Widget
local widget = require "widget"

------------------------------------------
--				Variables				--
------------------------------------------

-- Row Group
local rowGroup

-- Picker Wheel
local pickerWheel

-- Upper Functions
local rowOnTouch, closeDialog

-- Inputs
local inputRowFiles = {
	"addYourself.png",
	"addClient.png",
	"addDate.png",
	"typeOfMeeting.png",
	"cxoLevel.png",
	"busiOrIT.png",
	"alliance.png"
}

-- Input Data
local inputData = {
	["name"] = nil,
	["client"] = nil,
	["date"] = {localDate.day, localDate.month, localDate.year},
	["contact"] = nil,
	["level"] = nil,
	["business"] = nil,
	["opp"] = nil
}

-- Input Names
-- *some placeholders others full time!
local inputNames = {
	"Your name",
	"Company name",
	localDate.day.."."..localDate.month.."."..localDate.year,
	"Name of company contact",
	"Level of contact",
	"Business or IT",
	"Alliance"
}

-- Input Functions
local inputFunctions = {
	"simpelText",
	"simpelText",
	"date",
	"simpelText",
	"contactRadio",
	"businessRadio",
	"typeRadio"
	
}



-- Years
local yearTable = {}
for i=1, 100 do
	yearTable[i] = i+1990
end

-- Days
local dayTable = {}
for i=1, 31 do
	dayTable[i] = i
end

-- Scroll View
local scrollView = widget.newScrollView({
	horizontalScrollDisabled = true,
	hideBackground = true, 
	topPadding = 0, 
	bottomPadding = 600
})

------------------------------------------
--			Display Objects				--
------------------------------------------

-- Background
local background = display.newRect(0, 0, 640, 1136)
background:setFillColor(200, 200, 200)
background.x, background.y = display.contentCenterX, display.contentCenterY
localGroup:insert(background)

-- Header 
local header = display.newImage("images/finish2.png")
localGroup:insert(scrollView)
scrollView:insert(header)

-- Buttom
local buttom = display.newImage("images/finish2.png")
buttom.isVisible = false
buttom.y = display.contentHeight
scrollView:insert(buttom)


------------------------------------------
--			Input Functions				--
------------------------------------------

-- Remove Keyboard Focus
local function removeKeyboardFocus()	
	native.setKeyboardFocus( nil )
end
background:addEventListener("tap", removeKeyboardFocus)

-- Cancel Row Touch
local function cancelRowTouch()
	for i=1, rowGroup.numChildren do
		rowGroup[i]:removeEventListener("tap", rowOnTouch)	
	end
	scrollView:setIsLocked( true )
end

-- Re Initialize Row Touch
local function reInitRowTouch()
	for i=1, rowGroup.numChildren do
		rowGroup[i]:addEventListener("tap", rowOnTouch)	
	end
	scrollView:setIsLocked( false )
end

-- Date Input
local function dateInput()
	
	-- Days
	local days = {
		{ align = "left", width = 50, startIndex = inputData["date"][1], labels = dayTable},
		{align = "center", width = 170, startIndex = inputData["date"][2], labels = {"January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"}},
		{align = "right", width = 80, startIndex = table.indexOf(yearTable, inputData["date"][3]) ,labels = yearTable}
	}
	-- Day Wheel
	local dayWheel = widget.newPickerWheel{
		columns = days, 
		font = native.systemFont,
		fontSize = 30
	}

	dayWheel.x = 0--display.contentCenterX-dayWheel.width*0.5-100
	dayWheel.y = display.contentHeight/3.5
	
	return dayWheel
end


------------------------------------------
--				Functions				--
------------------------------------------

-- Put Stutt In Text Fields
local function putStuffInTextFields(textField, index)
	textField.placeholder = inputNames[index]
	if index == 1 and jsonHandler.getName() ~= nil then
		textField.text = jsonHandler.getName()
	end	
end

-- Text Field Listener
local function textFieldListener(e)
	if e.phase == "ended" or e.phase == "submitted" then		
		removeKeyboardFocus()
	elseif e.phase == "began" then
		local x,y = scrollView:getContentPosition()
		if 0-e.target.y < 0-display.contentCenterY then
			scrollView:scrollToPosition({y=0-e.target.y})
		end
	end
end

-- Create TextFields
local function createTextfields(obj, index)
	local textField = native.newTextField( 60, 5+obj[2].y-obj[2].height/2, obj[2].width-10, 60)
	textField.hasBackground = false
	textField.type = index
	textField.font = native.newFont(native.systemFont, 16 )
	textField:addEventListener("userInput", textFieldListener)
	scrollView:insert(textField)
	obj.textfield = textField
	putStuffInTextFields(textField, index)
end

-- Row Listenr
local function rowTransitionListener(obj)
	createTextfields(obj, obj.type)
end

-- Option Listener
local function optionListener(e)
	e.target.alpha = 0.1
	transition.to(e.target,{alpha=1})
	e.target:setFillColor(200, 255, 200)
	e.target.other:setFillColor(255, 255, 255)
	inputData[e.target.dataType] = e.target.value
end

-- Pupulate Radio Buttons
local function populateRadioButtons(dataType, value1, value2, backplate, file1, file2)
	local radioGroup = display.newGroup()
	local option1 = display.newImage(file1)
	local option2 = display.newImage(file2)
	option1.y, option2.y = backplate.y, backplate.y
	option1.x, option2.x = backplate.x-125, backplate.x+185
	option1.other = option2
	option2.other = option1
	option1.value, option2.value = value1, value2
	option1.dataType, option2.dataType = dataType, dataType
	radioGroup:insert(option1)
	radioGroup:insert(option2)
	option1:addEventListener("tap", optionListener)
	option2:addEventListener("tap", optionListener)
	return radioGroup
end

-- Put Stuff On Row
local rowTable = {header}
local function putStuffOnRow(i)
	
	local inputKind = inputFunctions[i]
	local tempGroup = display.newGroup()
	tempGroup.type = i
	local newRow, backplate
	
	if inputKind == "simpelText" then
		newRow = display.newImage("images/emptyRow.png")
		newRow:translate(-display.contentWidth,  rowTable[i].y+rowTable[i].height*0.5+2)
		newRow.alpha = 0
		
		backplate = display.newImageRect("images/backplate.png", 550, 72)
		backplate.x, backplate.y = newRow.x, newRow.y
		backplate.alpha = 0.9
		backplate.transFinishFunction = rowTransitionListener
	elseif inputKind == "date" then
		
		newRow = display.newImageRect("images/"..inputRowFiles[i], 640, 301)
		newRow:translate(-display.contentWidth*0.5,  rowTable[i].y+rowTable[i].height*0.5+newRow.height*.5+2)
		newRow.alpha = 0
			
		backplate = dateInput()
		backplate.x, backplate.y = newRow.x-150, newRow.y-100
		backplate.alpha = 0.9
		backplate.transFinishFunction = nil
		
		-- Assigning Picker Wheel To Picker Wheel Object
		pickerWheel = backplate
	elseif inputKind == "contactRadio" then
		newRow = display.newImage("images/emptyRow.png")
		newRow:translate(-display.contentWidth,  rowTable[i].y+rowTable[i].height*0.5+2)
		newRow.alpha = 0
		
		backplate = display.newImageRect("images/backplate.png", 550, 72)
		backplate.x, backplate.y = newRow.x, newRow.y
		backplate.alpha = 0.9
		backplate.transFinishFunction = nil
		backplate.options = populateRadioButtons("level", "Other", "CXO", backplate,"images/otherRadio.png","images/cxoRadio.png")
		
	elseif inputKind == "businessRadio" then
		newRow = display.newImage("images/emptyRow.png")
		newRow:translate(-display.contentWidth,  rowTable[i].y+rowTable[i].height*0.5+2)
		newRow.alpha = 0
				
		backplate = display.newImageRect("images/backplate.png", 550, 72)
		backplate.x, backplate.y = newRow.x, newRow.y
		backplate.alpha = 0.9
		backplate.transFinishFunction = nil
		backplate.options = populateRadioButtons("business", "Business", "IT", backplate,"images/businessRadio.png","images/itRadio.png")
		
	elseif inputKind == "typeRadio" then
		newRow = display.newImage("images/emptyRow.png")
		newRow:translate(-display.contentWidth,  rowTable[i].y+rowTable[i].height*0.5+2)
		newRow.alpha = 0
				
		backplate = display.newImageRect("images/backplate.png", 550, 72)
		backplate.x, backplate.y = newRow.x, newRow.y
		backplate.alpha = 0.9
		backplate.transFinishFunction = nil
		backplate.options = populateRadioButtons("opp", "Non-Opp", "Opp", backplate,"images/nonOppRadio.png","images/oppRadio.png")
			
	else
		newRow = display.newImage("images/emptyRow.png")
		newRow:translate(-display.contentWidth,  rowTable[i].y+rowTable[i].height*0.5+2)
		newRow.alpha = 0
		
		backplate = display.newImageRect("images/backplate.png", 550, 72)
		backplate.x, backplate.y = newRow.x, newRow.y
		backplate.alpha = 0.9
		backplate.transFinishFunction = rowTransitionListener
	end
	rowTable[i+1] = newRow
	tempGroup:insert(newRow)
	tempGroup:insert(backplate)
	if backplate.options then
		tempGroup:insert(backplate.options)
	end
	
	return tempGroup
end


-- Load Input Rows
local function loadInputRows(e)
	rowGroup = display.newGroup()
	for i=1, #inputRowFiles, 1 do
		local tempGroup = putStuffOnRow(i)
		transition.to(tempGroup, {delay=i*40, x=display.contentWidth, transition=easing.outExpo,
		onComplete=tempGroup[2].transFinishFunction})
		rowGroup:insert(tempGroup)	
	end
	scrollView:insert(rowGroup)
	header:toFront()
	buttom:toFront()
end
loadInputRows()

-- Perform Finish
local function performFinish(e)
	if "clicked" == e.action then
	  	local i = e.index
	    if 2 == i then
		inputData["name"] = rowGroup[1].textfield.text
		inputData["client"] 	= rowGroup[2].textfield.text
		inputData["date"][1] 	= pickerWheel:getValues()[1].value+0
		inputData["date"][2] 	= pickerWheel:getValues()[2].index+0
		inputData["date"][3] 	= pickerWheel:getValues()[3].value+0 
		inputData["contact"] 	= rowGroup[4].textfield.text
		jsonHandler.setName(inputData["name"])
			
			local serverReply = portal.registerMeeting(inputData)
			if serverReply ~= "success" then
				native.showAlert( "Ooops", "The server didn't respond! Please check your internet connection and try again" , {"Alright!"} )
			else
				display.remove(pickerWheel)
				jsonHandler.setMeetings()
				jsonHandler.addNewInteraction(inputData)
				director:changeScene("menu", "moveFromLeft")
				native.showAlert( "Success!", "Thank you for registering your meeting" , {"Alright!"} )
			end
		end
	end
end

-- Finish
local function finish(e)
	if e.x < 200 then
		display.remove(pickerWheel)
		director:changeScene("menu", "moveFromLeft")
	elseif e.x > 440 then
		native.showAlert( "Finished?", "You won't be able to redo any registered meetings" , { "Not Yet", "Yes!" }, performFinish )
		e.target.alpha = 0.5
		transition.to(e.target, {time=200, alpha=1})
	end
end
header:addEventListener("tap", finish)

-------------- BELOW DIRECTOR -------------
	return localGroup
end