resource_manifest_version '77731fab-63ca-442c-a67b-abc70f28dfa5'

description "Server Side Trainer to replace the Lambda Menu. Created by TheStonedTurtle/Michael Goodwin."

ui_page "nui/trainer.html"

files {
	"nui/trainer.html",
	"nui/trainer.js",
	"nui/trainer.css",
	"nui/Roboto.ttf",
	"nui/Lemonada.ttf",
	"nui/Roboto-Black.ttf"
}


client_scripts {
	"variables.lua",      		  -- Create all default variables. 
	"general.lua",        		  -- User Managment/Trainer Controls/Global Functions
	"map.lua",			  		  -- Map Blips.
	"player.lua",	      		  -- Player Toggles & Options
	"settings.lua",	      		  -- General Settings (Player Blips etc)
	"settings-voice.lua", 		  -- Handles all voice-chat related settings
	"settings-notifications.lua", -- Handles Player & Death Notifications
	"player-skin.lua",    		  -- Player Skins & Props
	"player-online.lua",  		  -- Other Player Options (Teleport/Spectate)
	"vehicles.lua",       		  -- Vehicle Spawning/Modifications
	"weapons.lua",        		  -- Weapon Spawning/Attachments
	"admin.lua" 		  		  -- Handles Admin Menu Access & Options
}

server_scripts{
	"admin-server.lua"    		  -- Handles Cross-Player Admin Commands
}