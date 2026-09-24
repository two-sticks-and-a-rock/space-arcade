extends Line2D

@onready var player = get_parent() as RigidBody2D

enum speed_options { LINEAR, SQRT, SQUARE }
var speed_type = speed_options.LINEAR

var start_vector := Vector2.ZERO
var end_vector := Vector2.ZERO

func handle_speed(slingshot_vector: Vector2):
	if (speed_type == speed_options.LINEAR):
		player.direction = slingshot_vector.normalized()
		player.velocity = slingshot_vector.length()
	
	if (speed_type == speed_options.SQRT):
		player.direction = slingshot_vector.normalized()
		player.velocity = 40 + (sqrt(slingshot_vector.length() * 100) * 5)

	if (speed_type == speed_options.SQUARE):
		player.direction = slingshot_vector.normalized()
		player.velocity = pow(slingshot_vector.length(), 1.5)

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("linear"):
		speed_type = speed_options.LINEAR
	if Input.is_action_just_pressed("sqrt"):
		speed_type = speed_options.SQRT
	if Input.is_action_just_pressed("pow"):
		speed_type = speed_options.SQUARE

	if Input.is_action_just_pressed("click"):
		clear_points()
		# The moment the mouse click happens, save the start vector
		start_vector = get_global_mouse_position()
		end_vector = start_vector
	if Input.is_action_pressed("click"):
		# While the player holds the button, update the end_vector
		end_vector = get_global_mouse_position()
		clear_points()

		var visible_start_vector = to_local(player.global_position)
		var visible_end_vector = to_local(player.global_position + (start_vector - end_vector))
		add_point(visible_start_vector, 0)
		add_point(visible_end_vector, 1)
	if Input.is_action_just_released("click"):
		# When the player releases, set the direction of the ship
		clear_points()
		var slingshot_vector = start_vector - end_vector
		handle_speed(slingshot_vector)
