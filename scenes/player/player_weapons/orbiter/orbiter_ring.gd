extends PlayerWeapon

var spin_speed = PI/36
var distance_from_player = 200

func _ready():
	up_timer.start()

	var child_pos = Vector2(distance_from_player, 0)
	for i in bullets:
		var orbiter = bullet_scene.instantiate() as Area2D
		orbiter.position = child_pos
		add_child(orbiter)
		child_pos = child_pos.rotated(2*PI / bullets)

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
