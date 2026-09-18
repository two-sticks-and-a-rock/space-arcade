extends Camera2D

@onready var background = get_parent().get_parent().get_node("background") # TODO: this is...super janky
var min_coord
var max_coord
var screen_size

func _ready():
	screen_size = get_viewport_rect().size
	var background_sprite = background as Sprite2D
	var background_texture = background_sprite.texture
	var background_size = background_texture.get_size() * background_sprite.scale
	var background_pos = background_sprite.position

	min_coord = background_pos - background_size/2 + (screen_size/2)
	max_coord = background_pos + background_size/2 - (screen_size/2)


func _process(_delta):
	if (position != Vector2.ZERO):
		position -= position.normalized()
	if position.length() < 1: 
		position = Vector2(0,0)
	global_position = global_position.clamp(min_coord, max_coord)
