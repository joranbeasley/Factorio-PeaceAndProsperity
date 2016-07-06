require("utils_peaceprosperity")

local current_button = 0
local player
local surface
local is_first_load = nil
--------------------------------------------------------------------------------------
function create_gui()
    player.gui.top.add({type = "frame", name = "jmod_main_frameA", caption = "", direction = "horizontal", style = "jmod_frame_style"})
    player.gui.top.jmod_main_frameA.add({type="flow",name="container",direction="vertical"})
    player.gui.top.jmod_main_frameA.container.add({type="flow",name="main",direction="horizontal"})
    player.gui.top.jmod_main_frameA.container.add({type="flow",name="bottom",direction="horizontal"})

    player.gui.top.jmod_main_frameA.container.main.add({type = "button", name = "but_mobs", caption = "Mobs Aggressive", font_color = red, style = "jmod_button_style"})
    player.gui.top.jmod_main_frameA.container.main.add({type = "button", name = "but_resources", style = "jmod_button_none_style"})
    player.gui.top.jmod_main_frameA.container.main.add({type = "button", name = "but_deploy", caption = "Deploy Resource" , font_color = white, style = "jmod_button_style"})

    player.gui.top.jmod_main_frameA.container.bottom.add({type="label",name="lbl_deploy",caption="test",font_color="white"})
    player.gui.top.jmod_main_frameA.container.bottom.add({type="checkbox",name="cb_minify",caption="tiny",state=false,font_color="white"})
end
-- This function allows pre 0.1.5 version existing games to load

function create_maximizer()
    player.gui.left.add({type = "button", name = "jmod_frameB", caption = "", direction = "horizontal", style = "jmod_button_angry_style"})
end

function on_init()
    is_first_load = true
    player = game.players[1]
    surface = player.surface
    if player.gui.top.jmod_main_frameA ~= nil and player.gui.top.jmod_main_frameA.container == nil then
        player.gui.top.jmod_main_frameA.destroy()
    end
    if player.gui.top.jmod_main_frameA == nil and player.gui.left.jmod_frameB == nil then
        create_gui()
    end
    update_buttons()
end

function toggle_gui()
    if player.gui.top.jmod_main_frameA ~= nil then
        player.gui.top.jmod_main_frameA.destroy()
        create_maximizer()
    else
        if player.gui.left.jmod_frameB ~= nil then
            player.gui.left.jmod_frameB.destroy()
        end
        create_gui()
    end
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
            surface.peaceful_mode = not surface.peaceful_mode
            if surface.peaceful_mode then
                game.forces["enemy"].kill_all_units()
                debug_print("Peaceful Enabled")
            else
                debug_print("Aggressive Enabled!")
            end
        elseif event.element.name == "but_resources" then
            current_button = current_button + 1
        elseif event.element.name == "but_deploy" then

            current_button,resource = resource_from_index(current_button)

            if resource.item_name == "crude-oil" then
                local positions = {{-2,-2},{2,2},{0,0},{-2,2},{2,-2}}
                for i, pair in ipairs(positions) do
                    local x,y = pair[1],pair[2]
                    surface.create_entity({name="crude-oil", amount=50000, position={player.position.x+x, player.position.y+y}})
                end
            elseif resource.item_name == "clear" then
                local area = {{player.position.x-2,player.position.y-2},{player.position.x+2,player.position.y+2}}
                for i,entity in ipairs(surface.find_entities(area)) do
                    if entity.name ~= "player" then
                        entity.destroy()
                    end
                end
            else
                for y=-2,2 do
                    for x=-2,2 do
                        surface.create_entity({name=resource.item_name, amount=50000, position={player.position.x+x, player.position.y+y}})
                    end
                end
            end
            debug_print("Deployed : %s",resource.item_name)
        elseif event.element.name == "cb_minify" or event.element.name == "jmod_frameB" then
            toggle_gui()
        end
        update_buttons()
    end
)

--------------------------------------------------------------------------------------
function update_minigui()
    if surface.peaceful_mode then
        player.gui.left.jmod_frameB.style ="jmod_button_happy_style"
    else
        player.gui.left.jmod_frameB.style ="jmod_button_angry_style"
    end
end

function update_maingui()
    current_button,resource = resource_from_index(current_button)
    player.gui.top.jmod_main_frameA.container.main.but_resources.style =  resource.style
    local caption,caption2,font_color
    if resource.item_name == "clear" then
        caption = "Clear Area"
        caption2 = "Clear Area"
        font_color = red
    else
        caption = "Deploy: "..resource.item_name.."      "
        caption2 = "Deploy Resource"
        font_color = white
    end
    player.gui.top.jmod_main_frameA.container.bottom.lbl_deploy.caption = caption
    player.gui.top.jmod_main_frameA.container.main.but_deploy.style.font_color = font_color
    player.gui.top.jmod_main_frameA.container.main.but_deploy.caption = caption2
    if not surface.peaceful_mode then
        player.gui.top.jmod_main_frameA.container.main.but_mobs.style.font_color = red
        player.gui.top.jmod_main_frameA.container.main.but_mobs.caption = "Mobs Aggressive"
    else
        player.gui.top.jmod_main_frameA.container.main.but_mobs.style.font_color = green
        player.gui.top.jmod_main_frameA.container.main.but_mobs.caption = "Mobs Peaceful  "
    end
end

function update_buttons()
    -- update buttons ... it should only be called explicitly after a state change event (gui click for example)
    if player.gui.top.jmod_main_frameA ~= nil then
        update_maingui()
    elseif player.gui.left.jmod_frameB ~= nil then
        update_minigui()
    end
end

