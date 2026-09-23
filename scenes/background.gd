extends TileMapLayer

@onready var blue_background = tile_set.get_source(0) as TileSetAtlasSource

var screen_size
var visible_buffer = 64

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
	
	for col in tile_cols:
		for row in tile_rows:
			print(Vector2(col,row))
			set_random_tile(Vector2i(col, row), 0)
