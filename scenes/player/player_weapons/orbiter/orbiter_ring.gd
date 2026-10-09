extends PlayerWeapon

var distance_from_player = 200

func _ready():
	super()
	up_timer.start()

	var child_pos = Vector2(distance_from_player, 0)
	for i in num_bullets:
		var orbiter = bullet_scene.instantiate() as Area2D
		orbiter.position = child_pos

		orbiter._scale_bullet(Vector2(bullet_size, bullet_size))
		add_child(orbiter)
		child_pos = child_pos.rotated(2*PI / num_bullets)

func _on_down_timer_timeout():
	up_timer.start()
	down_timer.stop()

	for child in get_children():
		if child is Area2D:
			child.visible = true
			child.process_mode = Node.PROCESS_MODE_INHERIT

func _on_up_timer_timeout():
	down_timer.start()
	up_timer.stop()

	for child in get_children():
		if child is Area2D:
			child.visible = false
			child.process_mode = Node.PROCESS_MODE_DISABLED
