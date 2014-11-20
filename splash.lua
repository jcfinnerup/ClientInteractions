module(..., package.seeall)

function new()

	local localGroup = display.newGroup()

-------------- ABOVE DIRECTOR -------------

------------------------------------------
--			   Requirements				--
------------------------------------------


------------------------------------------
--				Variables				--
------------------------------------------


------------------------------------------
--			Display Objects				--
------------------------------------------

-- Load Image
local loadImage = display.newImageRect(loadUrl,display.contentWidth, display.contentHeight)
loadImage.x, loadImage.y = display.contentCenterX, display.contentCenterY
localGroup:insert(loadImage)

------------------------------------------
--				Functions				--
------------------------------------------

-- Go To Menu
local function goToMenu()
	director:changeScene("menu")
end
timer.performWithDelay(500, goToMenu)








-------------- BELOW DIRECTOR -------------
	return localGroup
end