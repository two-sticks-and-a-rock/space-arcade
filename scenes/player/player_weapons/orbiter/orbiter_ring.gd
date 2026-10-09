extends PlayerWeapon

var distance_from_player = 200

var current_bullets : Array[PlayerBullet]

func new_orbiter():
	up_timer.start()

	for current_bullet in current_bullets:
		remove_child(current_bullet)
		current_bullet.queue_free()
	current_bullets = []

	var child_pos = Vector2(distance_from_player, 0)
	for i in bullets:
		var orbiter = bullet_scene.instantiate() as PlayerBullet
		orbiter.position = child_pos
		add_child(orbiter)
		child_pos = child_pos.rotated(2*PI / bullets)
		current_bullets.append(orbiter)

func _reset():
	super()
	new_orbiter()

func _ready():
	new_orbiter()

func _on_down_timer_timeout():
	up_timer.start()
	down_timer.stop()
	visible = true

	for child in get_children():
		if child is PlayerBullet:
			child.process_mode = Node.PROCESS_MODE_INHERIT

func _on_up_timer_timeout():
	down_timer.start()
	up_timer.stop()
	visible = false

	for child in get_children():
		if child is PlayerBullet:
			child.process_mode = Node.PROCESS_MODE_DISABLED
