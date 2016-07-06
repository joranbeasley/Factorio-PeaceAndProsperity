require("constants")

for _,types in pairs(data.raw) do
	for _,entity in pairs(types) do
		if entity.icon and entity.type == "resource" then
			data.raw["gui-style"].default[ITEM_BUTTON_STYLE_PREFIX .. entity.name] = {
				type = "button_style",
				parent="jmod_button_style",
				scalable = false,
				top_padding = 0,
				right_padding = 0,
				bottom_padding = 0,
				left_padding = 0,
				width = 32,
				height = 32,
				default_graphical_set = item_graphical_set(entity.icon, false),
				hovered_graphical_set = item_graphical_set(entity.icon, true),
				clicked_graphical_set = item_graphical_set(entity.icon, true),
				disabled_graphical_set = item_graphical_set(entity.icon, false)
			}
		end
	end
end
