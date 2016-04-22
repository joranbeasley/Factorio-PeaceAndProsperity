require "defines"

debug_level = -1  -- eventually change this in on_init()/on_load() of the mod

white = {r = 1, g = 1, b = 1}
red = {r = 1, g = 0.3, b = 0.3}
green = {r = 0, g = 1, b = 0}
blue = {r = 0, g = 0, b = 1}
yellow = {r = 1, g = 1, b = 0}
orange = {r = 1, g = 0.5, b = 0}

--------------------------------------------------------------------------------------
function debug( s, lvl )
	if true then
		game.players[1].print(s)
		return
	end
	if debug_level == -1 then return end
	
	if lvl == nil then lvl = debug_level end
	
	if debug_mem == nil then debug_mem = {} end
	
	if s == "CLEAR" then
		for _, player in pairs(game.players) do
			player.clear_console()
		end
	end
	
	if (debug_level >= 0) and ((lvl >= debug_level) or (lvl == 0)) then 
		if game ~= nil and #game.players > 0 then
			if #debug_mem > 0 then
				for _, m in pairs( debug_mem ) do
					for _, player in pairs(game.players) do
						player.print(m)
					end
				end
				debug_mem = {}
				end
			
			if s ~= nil then 
				for _, player in pairs(game.players) do
					player.print(s)
				end
			end
		else
			table.insert( debug_mem, s )
		end
	end
end

--------------------------------------------------------------------------------------
function square_area( origin, radius )
	return {
		{x=origin.x - radius, y=origin.y - radius},
		{x=origin.x + radius, y=origin.y + radius}
	}
end

--------------------------------------------------------------------------------------
function min( val1, val2 )
	if val1 < val2 then
		return val1
	else
		return val2
	end
end

--------------------------------------------------------------------------------------
function max( val1, val2 )
	if val1 > val2 then
		return val1
	else
		return val2
	end
end

--------------------------------------------------------------------------------------
function iif( cond, val1, val2 )
	if cond then
		return val1
	else
		return val2
	end
end

function arrayLength(T)
   local count = 0
   for k,v in pairs(tbl) do count = count + 1 end
   return count
end
function explode(div,str)
    if (div=='') then return false end
    local pos,arr,ct = 0,{},0
    for st,sp in function() return string.find(str,div,pos,true) end do
        table.insert(arr,string.sub(str,pos,st-1))
        pos = sp + 1
		ct = ct + 1
    end
    table.insert(arr,string.sub(str,pos))
    return arr,ct
end
----------------------------------------------

--local btnstyles = {"none","stone","iron-ore","copper-ore","coal","oil"}
local btnstyles = {"stone","iron-ore","copper-ore","coal","oil"}
--local num_btnstyles = 6
local num_btnstyles = 5
function looping_index0_into_array(idx,T,sizeT)
    local safe_index = idx%sizeT
	return safe_index,T[safe_index+1]
end
function resource_from_index(idx)
	return looping_index0_into_array(idx,btnstyles,num_btnstyles)
end
function style_from_index(idx)
    safe_index,resource = resource_from_index(idx)
	style_name = explode("-",resource)[1]
	--debug(style_name)
	return safe_index,string.format("jmod_button_%s_style",style_name)
end

