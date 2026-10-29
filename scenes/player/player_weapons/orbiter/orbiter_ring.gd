extends PlayerWeapon

var distance_from_player = 200

var current_bullets : Array[PlayerBullet]

func _reinstantiate_weapon():
	super()
	for current_bullet in current_bullets:
		remove_child(current_bullet)
		current_bullet.queue_free()
	current_bullets = []

	var child_pos = Vector2(distance_from_player, 0)
	for i in num_bullets:
		var orbiter = bullet_scene.instantiate() as PlayerBullet
		orbiter.position = child_pos
		orbiter.bullet_scale = Vector2(bullet_size, bullet_size)*orbiter.scale_for_sprite
		add_child(orbiter)
		child_pos = child_pos.rotated(2*PI / num_bullets)
		current_bullets.append(orbiter)

	up_timer.start()

func _ready():
	super()
	up_timer.start()
	Sfx.play("orbiter_activate")

func _on_down_timer_timeout():
	up_timer.start()
	down_timer.stop()
	Sfx.play("orbiter_activate")

	for child in get_children():
		if child is Area2D:
			child.process_mode = Node.PROCESS_MODE_INHERIT

func _on_up_timer_timeout():
	down_timer.start()
	up_timer.stop()

	for child in get_children():
		if child is Area2D:
			child.process_mode = Node.PROCESS_MODE_DISABLED

func _physics_process(delta):
	if (!up_timer.is_stopped() && up_timer.time_left <= 1.0):
		for child in get_children():
			if child is PlayerBullet && child.scale > Vector2.ZERO:
				child.scale -= delta*Vector2.ONE
	if (!down_timer.is_stopped() &&  down_timer.time_left <= 1.0):
		for child in get_children():
			if child is PlayerBullet && child.scale <=Vector2.ONE*bullet_size:
				child.scale += delta*Vector2.ONE
