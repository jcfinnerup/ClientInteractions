module(..., package.seeall)
print("Loading Navigator")


------------------------------------------
--			   Requirements				--
------------------------------------------


------------------------------------------
--				Variables				--
------------------------------------------

-- Scenes
local scenes = {
	
}

------------------------------------------
--				Functions				--
------------------------------------------

-- Previous Scene
function previousScene()
	print("Going to previous scene..")
end

-- Next Scene
function nextScene()
	print("Going to next scene..")
end

-- Go To List view
function goToListView()
	print("Going to list view")
	director:changeScene("addWithList", "moveFromRight")
end