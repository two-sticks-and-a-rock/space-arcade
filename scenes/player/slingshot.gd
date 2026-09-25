extends Line2D

@onready var player = get_parent() as RigidBody2D

var start_vector := Vector2.ZERO
var end_vector := Vector2.ZERO

func handle_speed(slingshot_vector: Vector2):
	player.direction = slingshot_vector.normalized()
	var velocity = slingshot_vector.length()
	var slingshot_velocity = velocity
	match SpeedCalc.speed_calc:
		SpeedCalc.speed_calc_options.LINEAR:
			player.slingshot_velocity = player.direction * (SpeedCalc.linear_base_speed + velocity * SpeedCalc.linear_speed_multiplier)
			return
		SpeedCalc.speed_calc_options.SQRT:
			player.slingshot_velocity = player.direction * (SpeedCalc.sqrt_base_speed + sqrt(velocity) * SpeedCalc.sqrt_speed_multiplier)
			return
		SpeedCalc.speed_calc_options.POW:
			player.slingshot_velocity = player.direction * (SpeedCalc.pow_base_speed + pow(velocity, SpeedCalc.pow_power) * SpeedCalc.pow_speed_multiplier)
			return

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("click"):
		clear_points()
		start_vector = get_global_mouse_position()
		end_vector = start_vector
	if Input.is_action_pressed("click"):
		end_vector = get_global_mouse_position()
		clear_points()

		var visible_start_vector = to_local(player.global_position)
		var visible_end_vector = to_local(player.global_position + (start_vector - end_vector))
		add_point(visible_start_vector, 0)
		add_point(visible_end_vector, 1)

	if Input.is_action_just_released("click"):
		clear_points()
		var slingshot_vector = start_vector - end_vector
		handle_speed(slingshot_vector)
