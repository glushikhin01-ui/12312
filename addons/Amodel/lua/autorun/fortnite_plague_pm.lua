// Ported by Maygik

local modelName = "Plague"
local modelPath = "fortnite/plague"

list.Set( "PlayerOptionsModel", modelName, 	"models/" .. modelPath .. ".mdl" )
player_manager.AddValidModel( 	modelName, 	"models/" .. modelPath .. ".mdl" )
player_manager.AddValidHands( 	modelName, 	"models/" .. modelPath .. "_arms.mdl", 0, "00000000" )