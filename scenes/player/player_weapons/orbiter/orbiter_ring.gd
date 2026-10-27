extends PlayerWeapon

var distance_from_player = 200
var min_distance_from_player = 80

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

func _on_down_timer_timeout():
	up_timer.start()
	down_timer.stop()

func _on_up_timer_timeout():
	down_timer.start()
	up_timer.stop()

	for child in get_children():
		if child is PlayerBullet:
			child.toggle_visibility(false)

func _physics_process(delta):
	var grow_rate : Vector2 = bullet_size * delta * Vector2.ONE
	var spiral_out_rate : float = (distance_from_player - min_distance_from_player) * delta

	for child in get_children():
		if child is PlayerBullet:
			var start_shrinking = !up_timer.is_stopped() && up_timer.time_left <= 1.0
			if (start_shrinking):
				if child.scale > Vector2.ZERO:
					child.scale -= grow_rate
					child.position -= child.position.normalized() * spiral_out_rate

			var start_growing = !down_timer.is_stopped() && down_timer.time_left <= 1.0
			if (start_growing):
				# need to set process_mode here otherwise the asteroids don't rotate as they come up
				child.toggle_visibility(true)
		
				if child.scale <= child.bullet_scale:
					child.scale += grow_rate
					child.position += child.position.normalized() * spiral_out_rate
			child.position = Vector2(child.position).rotated(bullet_speed)
