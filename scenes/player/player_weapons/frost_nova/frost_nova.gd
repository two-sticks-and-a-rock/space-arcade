extends PlayerWeapon

var current_bullets : Array[PlayerBullet]

@export var freeze_time: float = 5.0

func _reinstantiate_weapon():
	super()
	for current_bullet in current_bullets:
		remove_child(current_bullet)
		current_bullet.queue_free()
	current_bullets = []
	
	for i in num_bullets:
		var area = bullet_scene.instantiate() as PlayerBullet
		area.position = Vector2(0, 0)
		area.bullet_scale = Vector2(bullet_size, bullet_size)
		area.freeze_time = freeze_time
		add_child(area)
		current_bullets.append(area)

	up_timer.start()

func _ready() -> void:
	super()
	up_timer.start()

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
