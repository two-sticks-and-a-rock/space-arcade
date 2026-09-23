extends TileMapLayer

@onready var blue_background = tile_set.get_source(0) as TileSetAtlasSource
@onready var player = get_parent().get_node("player") as RigidBody2D

@onready var viewport_size = player.get_node("Camera2D").get_viewport_rect().size
var screen_size = viewport_size
var visible_buffer = 2048

var rng = RandomNumberGenerator.new()

func set_random_tile(coord: Vector2, source_id: int, ):
	var rng_atlas_x = rng.randi_range(0, blue_background.get_atlas_grid_size().x-1)
	var rng_atlas_y = rng.randi_range(0, blue_background.get_atlas_grid_size().y-1)
	set_cell(coord, source_id, Vector2i(rng_atlas_x, rng_atlas_y))

func _ready():
	rng.randomize()

	screen_size = get_viewport_rect().size + Vector2(visible_buffer, visible_buffer)
	var tile_cols = ceil(screen_size.x / tile_set.tile_size.x)
	var tile_rows = ceil(screen_size.y / tile_set.tile_size.y)
	
	var player_local_pos = to_local(player.global_position)
	for col in tile_cols:
		for row in tile_rows:
			var tile_pos = Vector2i(floor(player_local_pos.x - (tile_cols/2)+col), floor(player_local_pos.y - (tile_rows/2) +row))
			set_random_tile(tile_pos, 0)

func _process(_delta):
	# check if viewport is within visible buffer on top, bottom, left, or right
	# pre-render tiles
	# TODO may have to start removing tiles at some later size if this gets too big
	pass
