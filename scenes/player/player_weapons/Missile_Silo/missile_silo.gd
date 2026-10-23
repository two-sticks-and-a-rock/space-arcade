extends PlayerWeapon

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	up_timer.start()
	
func _on_down_timer_timeout():
	for i in (num_bullets):
		var missile = bullet_scene.instantiate()
		missile.rotate(randf_range(-PI / 4, PI / 4))
		missile.speed = Vector2(bullet_speed, 0)
		add_child(missile)
	up_timer.start()
	down_timer.stop()

func _on_up_timer_timeout() -> void:
	up_timer.stop()
	down_timer.start()
