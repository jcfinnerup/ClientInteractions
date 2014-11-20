module(..., package.seeall)

function new()

	local localGroup = display.newGroup()

-------------- ABOVE DIRECTOR -------------
print("Loading Menu..")

------------------------------------------
--			   Requirements				--
------------------------------------------
-- Widget
local widget = require "widget"
------------------------------------------
--				Variables				--
------------------------------------------

------------------------------------------
--			Display Objects				--
------------------------------------------

-- Background
local background = display.newImageRect("images/blueBackground.png", 640, 1136)
background.x, background.y = display.contentCenterX, display.contentCenterY
localGroup:insert(background)

-- Back Bar
local backBar = display.newRect(0, 0, display.contentWidth, 110)
backBar:setFillColor(121, 205, 248)
localGroup:insert(backBar)

-- Back
local back = display.newText("Back", 0, 0, system.nativeFont, 45)
back.x, back.y = display.contentCenterX, 70
back:setFillColor(0 ,0, 0)
localGroup:insert(back)


-- ScrollListener
local function scrollListener(e)
	-- Nothing
end

-- Row Rendering Options
-- this is what happenes with each individual row
local function renderTableViewTaps(e)


	-- Reference data
	local row = e.row
	local rowData = row.params
	
	-- ERROR
	local errorMsg = display.newText(row, "Missing some information...", 0, 0, system.nativeFont, 35)
	errorMsg:translate(0, row.height*.25)
	errorMsg:setFillColor(100, 100, 100)
	
	pcall( function()

	local date = rowData["date"][1].."/"..rowData["date"][2].."/"..rowData["date"][3]
	local opps = "("..rowData["level"]..", "..rowData["business"]..", "..rowData["opp"]..")"

	row.yScale = 1

	-- Client Name
	local clientName = display.newText(row, rowData["contact"], 0, 0, "arial bold", 35)
	clientName:translate(10, 10)
	clientName:setFillColor(50, 50, 50)
	
	-- Client Company
	local clientCompany = display.newText(row, rowData["client"], 0, 0, "arial bold", 35)
	clientCompany:translate(10, 60)
	clientCompany:setFillColor(100, 100, 100)
	
	-- Date
	local date = display.newText(row, date, 0, 0, "arial bold", 25)
	date:translate(row.width-150, 20)
	date:setFillColor(50, 50, 50)
	
	-- Details
	local details = display.newText(row, opps, 0, 0, "arial bold", 25)
	details:setReferencePoint(display.TopRightReferencePoint)
	details.x, details.y = row.width-10, 70
	details:setFillColor(100, 100, 100)
	
	errorMsg.isVisible = false
	
	end)
	
	
end


-- TABLE VIEW
interactionView = widget.newTableView
{
	top=backBar.y*2,
	left=0,
	width=display.contentWidth,
	height = display.contentHeight-backBar.y*2,
	topPadding = 0,
	bottomPadding = display.contentHeight*.5,
	onRowRender = renderTableViewTaps,
	listener = scrollListener,
	hideBackground = true,
}

------------------------------------------
--				Functions				--
------------------------------------------

-- GoBack
local function goBack(e)
	if e.phase == "began" then
		display.getCurrentStage():setFocus(e.target)
		e.target.alpha = 0.8
	elseif e.phase == "ended" then
		display.getCurrentStage():setFocus(nil)
		e.target.alpha = 1
		director:changeScene("menu", "moveFromLeft")
	end
end
backBar:addEventListener("touch", goBack)


-- Render Interactions
local function renderInteractions(interactions)
	for i = 1, #interactions do
	    interactionView:insertRow{
			params = interactions[i],
			rowHeight = 120,
			rowColor={ 
				default={ 255, 255, 255 }, 
				over={ 255, 255, 255, 1 } 
			},
		}
	end
end
renderInteractions(jsonHandler.getAllInteractions())

-------------- BELOW DIRECTOR -------------
	return localGroup
end