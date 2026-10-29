extends PlayerWeapon

var distance_from_player = 200
var min_distance_from_player = 80
var max_distance_from_player = 1000
var min_scale = 0.25

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
		orbiter.original_position = child_pos
		orbiter.bullet_scale = Vector2(bullet_size, bullet_size)
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

func _on_up_timer_timeout():
	down_timer.start()
	up_timer.stop()

	for child in get_children():
		if child is PlayerBullet:
			child.toggle_visibility(false)
			child.scale = Vector2.ONE * min_scale
			child.position = child.original_position.normalized() * min_distance_from_player

func _physics_process(delta):
	var grow_rate : Vector2 = (bullet_size - min_scale) * delta * Vector2.ONE
	var spiral_out_rate : float = (distance_from_player - min_distance_from_player) * delta
	var fly_out_rate : float = (max_distance_from_player - distance_from_player) * delta

	for child in get_children():
		if child is PlayerBullet:
			var start_flying = !up_timer.is_stopped() && up_timer.time_left <= 1.0
			if (start_flying):
				child.position += child.position.normalized() * fly_out_rate

			var start_growing = !down_timer.is_stopped() && down_timer.time_left <= 1.0
			if (start_growing):
				# need to set process_mode here otherwise the asteroids don't rotate as they come up
				child.toggle_visibility(true)
		
				if child.scale <= child.bullet_scale:
					child.scale += grow_rate
					child.position += child.position.normalized() * spiral_out_rate
			child.position = Vector2(child.position).rotated(bullet_speed)
