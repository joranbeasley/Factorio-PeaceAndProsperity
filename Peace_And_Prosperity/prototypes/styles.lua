require("utils_peaceprosperity")
data:extend(
	{
		{
			type = "font",
			name = "jmod_font",
			from = "default",
			border = false,
			size = 15
		},
		{
			type = "font",
			name = "jmod_font_bold",
			from = "default-bold",
			border = false,
			size = 15
		},
	}
)

local default_gui = data.raw["gui-style"].default

default_gui.jmod_frame_style = 
{
	type="frame_style",
	parent="frame_style",
	top_padding = 0,
	right_padding = 0,
	bottom_padding = 0,
	left_padding = 0,
}

default_gui.jmod_label_style =
{
	type="label_style",
	parent="default",
	font="jmod_font",
	align = "left",
	default_font_color={r=1, g=1, b=1},
	hover_font_color={r=0, g=1, b=0},
	top_padding = 0,
	right_padding = 0,
	bottom_padding = 0,
	left_padding = 0,
}

default_gui.jmod_button_style = 
{
	type="button_style",
	parent="default",
	font="jmod_font_bold",
	align = "center",
	default_font_color={r=1, g=1, b=1},
	hover_font_color={r=0, g=1, b=0},
	top_padding = 0,
	right_padding = 0,
	bottom_padding = 0,
	left_padding = 0,
	left_click_sound =
	{
		{
		  filename = "__core__/sound/gui-click.ogg",
		  volume = 1
		}
	},
}

function extract_monolith(xx, yy)
	return {
		type = "monolith",

		top_monolith_border = 0,
		right_monolith_border = 0,
		bottom_monolith_border = 0,
		left_monolith_border = 0,

		monolith_image = {
			filename = "__Peace_And_Prosperity__/graphics/happy_angry.png",
			priority = "extra-high-no-scale",
			width = 32,
			height = 32,
			x = xx,
			y = yy,
		},
	}
end


default_gui.jmod_button_none_style = 
{
    type = "button_style",
	parent="jmod_button_style",

	scalable = false,

	top_padding = 0,
	right_padding = 0,
	bottom_padding = 0,
	left_padding = 0,

	width = 32,
	height = 32,

	default_graphical_set = extract_monolith(64,  0),
	hovered_graphical_set = extract_monolith(64,  0),--extract_monolith(23,  30),
	clicked_graphical_set = extract_monolith(64,  0),--extract_monolith(46,  30),
}

default_gui.jmod_button_angry_style =
{
    type = "button_style",
	parent="jmod_button_style",

	scalable = false,

	top_padding = 0,
	right_padding = 0,
	bottom_padding = 0,
	left_padding = 0,

	width = 16,
	height = 16,

	default_graphical_set = extract_monolith(32,  0),
	hovered_graphical_set = extract_monolith(32,  0),--extract_monolith(23,  30),
	clicked_graphical_set = extract_monolith(32,  0),--extract_monolith(46,  30),
}
default_gui.jmod_button_happy_style =
{
    type = "button_style",
	parent="jmod_button_style",

	scalable = false,

	top_padding = 0,
	right_padding = 0,
	bottom_padding = 0,
	left_padding = 0,

	width = 16,
	height = 16,

	default_graphical_set = extract_monolith(0,  0),
	hovered_graphical_set = extract_monolith(0,  0),--extract_monolith(23,  30),
	clicked_graphical_set = extract_monolith(0,  0),--extract_monolith(46,  30),
}
