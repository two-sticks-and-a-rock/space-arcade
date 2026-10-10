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
		orbiter.bullet_scale = Vector2(bullet_size, bullet_size)
		add_child(orbiter)
		child_pos = child_pos.rotated(2*PI / num_bullets)
		current_bullets.append(orbiter)

	up_timer.start()

func debug_handle_level_up():
	var handle_level_up = func():
		var nonapplied_upgrade_sets: Array[WeaponUpgradeSet] = possible_upgrade_sets.filter(
			func(upgrade_set: WeaponUpgradeSet):
				return !upgrade_set.applied
		)
		if (nonapplied_upgrade_sets.size() == 0):
			return
		
		var set_to_apply = nonapplied_upgrade_sets[0]
		upgrades += set_to_apply.upgrades
		_reinstantiate_weapon.call_deferred()

	handle_level_up.call_deferred()

func _ready():
	super()
	# FOR DEBUGGING #
	EventBus.level_up.connect(debug_handle_level_up)
	# FOR DEBUGGING #

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
