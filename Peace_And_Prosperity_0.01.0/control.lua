
require("utils")

local current_button = 0
local player
local is_first_load = nil
--------------------------------------------------------------------------------------
function on_init()
	is_first_load = true
	player = game.players[1]			
	surf = game.get_surface(1)							
	if player.gui.top.jmod_main_frameA == nil then			
			player.gui.top.add({type = "frame", name = "jmod_main_frameA", caption = "", direction = "horizontal", style = "jmod_frame_style"})
			player.gui.top.jmod_main_frameA.add({type = "button", name = "but_mobs", caption = "Mobs Aggressive", font_color = red, style = "jmod_button_style"})				
			player.gui.top.jmod_main_frameA.add({type = "button", name = "but_resources", style = "jmod_button_none_style"})
			player.gui.top.jmod_main_frameA.add({type = "button", name = "but_deploy", caption = "Deploy Resource" , font_color = white, style = "jmod_button_style"})							
	end
	update_buttons()
end

function init_gui(player)

end


script.on_event(defines.events.on_tick, 
    --runs every tick ... really I would like to just call once when world is first loaded but meh...
	function(event)
		if is_first_load == nil then -- instructions run once, when the world is first loaded (not after a save)
			on_init()
		end
	end
)

--------------------------------------------------------------------------------------
script.on_event(defines.events.on_gui_click, 
    -- handle when a user clicks our gui
	function(event)
		if event.element.name == "but_mobs" then
			game.peaceful_mode = not game.peaceful_mode
			if game.peaceful_mode then
				game.forces["enemy"].kill_all_units()
				debug("Peaceful Enabled")
			else
				debug("Aggressive Enabled!")
			end
		elseif event.element.name == "but_resources" then
			current_button = current_button + 1
		elseif event.element.name == "but_deploy" and current_button > 0 then
			local idx,resource = resource_from_index(current_button)
			local surface = game.players[1].surface 
			if resource ~= "oil" then
				for y=-2,2 do
					for x=-2,2 do    
						surface.create_entity({name=resource, amount=5000, position={player.position.x+x, player.position.y+y}})   
					end  
				end
			else
				local positions = {{-2,-2},{2,2},{0,0},{-2,2},{2,-2}}
				for i, pair in ipairs(positions) do
					local x,y = pair[1],pair[2]
					surface.create_entity({name="crude-oil", amount=5000, position={player.position.x+x, player.position.y+y}})   					
				end
			end	
			debug(string.format("Deployed : %s",resource))
		end
		update_buttons()
	end
)

--------------------------------------------------------------------------------------
function update_buttons()  
    -- update buttons ... it should only be called explicitly after a state change event (gui click for example)  	
	current_button,style = style_from_index(current_button)	
	player.gui.top.jmod_main_frameA.but_resources.style =  style
	if not game.peaceful_mode then
		player.gui.top.jmod_main_frameA.but_mobs.style.font_color = red
		player.gui.top.jmod_main_frameA.but_mobs.caption = "Mobs Aggressive"
	else
		player.gui.top.jmod_main_frameA.but_mobs.style.font_color = green
		player.gui.top.jmod_main_frameA.but_mobs.caption = "Mobs Peaceful"
	end	
end
