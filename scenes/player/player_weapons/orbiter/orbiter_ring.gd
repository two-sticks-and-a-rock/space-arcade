extends PlayerWeapon

var distance_from_player = 200

var current_bullets : Array[PlayerBullet]

func _get_upgrade_sets():
	return [
	{
		"name": "Better Time",
		"upgrades": [
			{
				"label": "Uptime 6s -> 7s (+1s)",
				"resource": UpTimerUpgrade,
				# "resource": "res://scenes/player/player_weapons/base_weapon_upgrades/up_timer_upgrade.tres",
				"value": 1,
			},
			{
				"label": "Downtime 8s -> 7s (-1s)",
				# "resource": "res://scenes/player/player_weapons/base_weapon_upgrades/down_timer_upgrade.tres",
				"resource": DownTimerUpgrade,
				"value": 1,
			},
		],
		"applied": false
	},
	{
		"name": "More Bullets",
		"upgrades": [
			{
				"label": "Damage 50 -> 75 (+25)",
				"resource": DamageUpgrade,
				# "resource": "res://scenes/player/player_weapons/base_weapon_upgrades/down_timer_upgrade.tres",
				"value": 25,
			},
			{
				"label": "Asteroids 2 -> 3 (+1)",
				"resource": BulletsUpgrade,
				# "resource": "res://scenes/player/player_weapons/base_weapon_upgrades/down_timer_upgrade.tres",
				"value": 1,
			},
		],
		"applied": false
	},
]

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
