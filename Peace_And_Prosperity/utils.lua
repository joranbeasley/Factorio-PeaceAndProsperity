require "defines"
require ("constants")

debug_level = -1  -- eventually change this in on_init()/on_load() of the mod

white = {r = 1, g = 1, b = 1}
red = {r = 1, g = 0.3, b = 0.3}
green = {r = 0, g = 1, b = 0}
blue = {r = 0, g = 0, b = 1}
yellow = {r = 1, g = 1, b = 0}
orange = {r = 1, g = 0.5, b = 0}






function string.startswith(String,Start)
   return string.sub(String,1,string.len(Start))==Start
end

function string.endswith(String,End)
   return End=='' or string.sub(String,-string.len(End))==End
end
table.filter = function(t, filterIter)
  local out = {}

  for k, v in pairs(t) do
    if filterIter(v, k, t) then out[k] = v end
  end

  return out
end


--------------------------------------------------------------------------------------
function debug_log(s,...)
	--if not args then s,args="%s",{s,} end
	local file = io.open("peaceandprosperity.log.txt", "a")
	--if arg then
		file:write(string.format(s+"\n",...))
	--else
	--    file:write(s+"\n")
	-- end
end
function debug_print( s, ... )
	--if not args then s,args="%s",{s,} end
	--if arg then
	game.players[1].print(string.format(s,...))
	--else
	--	game.players[1].print(s)
	--end
end

function item_picture (icon, highlight)
	local pic = {
		filename = icon,
		width = 32,
		height = 32
	}
	if USE_CHECKBOXES then
		pic.shift = { 0, -8 }
	end
	if highlight then
		-- setting values > 1 seems to just make the image disappear. in any case this
		-- is just temporary until i figure out how to draw a slot-style highlighted bg.
		pic.tint = {r=0.5,g=0.5,b=0.5,a=1}
	end
	return pic
end
--[[
Returns a graphical_set table given an icon filename, optionally highlighted (a boolean)
as in the case of click / hover.
--]]

function item_graphical_set (icon, highlight)
	return {
		type = "monolith",
		monolith_image = item_picture(icon, highlight)
	}
end

--[[
Check if an object has a flag set. Note that data.raw is not LuaItemPrototype yet, so there is
no .has_flag() function. We just check in .flags.
--]]

function has_flag (flags, flag)
	if not flags then
		return false
	end
	for _,f in pairs(flags) do
		if f == flag then
			return true
		end
	end
	return false
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


function looping_index0_into_array(idx,T,sizeT)
    local safe_index = idx%sizeT
	return safe_index,T[safe_index+1]
end

local g_item_info = nil
function ensure_item_info_initialized ()

	if g_item_info then
		return
	end


	g_item_info = {
        {
                style = "jmod_button_none_style",
				item_name = "clear",
				stack_size = stack_size
        },
    }
    --game.write_file("items.log","Start File")
    for _,item_list in pairs({game.entity_prototypes,game.item_prototypes}) do
        for name,item in pairs(item_list) do
            if item.type == "resource" then
                local stack_size = 1
--                game.write_file("items.log",string.format("%s=>%s\n","name",item.name),"a")
--                game.write_file("items.log",string.format("%s=>%s\n","type",item.type),"a")
--                game.write_file("items.log","\n-------\n\n","a")
                table.insert(g_item_info,{
                    style = ITEM_BUTTON_STYLE_PREFIX..name,
                    item_name = name,
                    stack_size = stack_size
                })

            end
        end
    end
end
function get_resources()
    ensure_item_info_initialized()
    return g_item_info


end

function resource_from_index(idx)
    resources = get_resources()
	return looping_index0_into_array(idx,resources,#resources)

end
function style_from_index(idx)
    safe_index,resource = resource_from_index(idx)
	return safe_index,resource["style"]
end


