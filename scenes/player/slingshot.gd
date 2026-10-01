extends Line2D

@onready var player = get_parent() as StaticBody2D

var end_vector := Vector2.ZERO

func handle_speed(slingshot_vector: Vector2):
		Mover.direction = slingshot_vector.normalized()
		Mover.speed = slingshot_vector.length()

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("click"):
		end_vector = get_global_mouse_position()
	if Input.is_action_just_released("click"):
		var slingshot_vector = -1*end_vector
		handle_speed(slingshot_vector)

func _physics_process(_delta):
	clear_points()
	add_point(Vector2.ZERO, 0)
	add_point(-1*get_global_mouse_position(), 1)
