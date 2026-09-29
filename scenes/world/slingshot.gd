extends Line2D

@onready var world = get_parent().get_node("World") as Node2D

var start_vector := Vector2.ZERO
var end_vector := Vector2.ZERO

func handle_speed(slingshot_vector: Vector2):
		world.direction = slingshot_vector.normalized()
		world.speed = slingshot_vector.length()

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("click"):
		clear_points()
		start_vector = get_global_mouse_position()
		end_vector = start_vector
	if Input.is_action_pressed("click"):
		end_vector = get_global_mouse_position()
		clear_points()

		var visible_start_vector = to_local(world.global_position)
		var visible_end_vector = to_local(world.global_position + (start_vector - end_vector))
		add_point(visible_start_vector, 0)
		add_point(visible_end_vector, 1)

	if Input.is_action_just_released("click"):
		clear_points()
		var slingshot_vector = start_vector - end_vector
		handle_speed(slingshot_vector)
