extends Parallax2D

var scroll_x = 0.0
var scroll_y = 0.0

func _ready():
	# ignore_camera_scroll = true
	# follow_viewport = false
	pass

func _physics_process(delta):
	scroll_x -= Mover.get_movement().x * delta
	scroll_y -= Mover.get_movement().y * delta
	scroll_offset = Vector2(scroll_x, scroll_y)
