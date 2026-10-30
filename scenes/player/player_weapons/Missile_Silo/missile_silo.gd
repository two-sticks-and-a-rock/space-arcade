extends PlayerWeapon

@onready var silo_sprite : AnimatedSprite2D = $AnimatedSprite2D

@onready var stagger_missiles_timer : Timer = Timer.new()

func _ready() -> void:
	super()
	stagger_missiles_timer.one_shot = true
	stagger_missiles_timer.wait_time = 0.10
	add_child(stagger_missiles_timer)
	
	silo_sprite.play()

	# Use the down timer to decide how fast the animation is
	silo_sprite.sprite_frames.set_animation_speed("default", 3/down_timer.wait_time)
	spawn_missiles()
	down_timer.start()

func _on_missile_down_timer_timeout():
	down_timer.stop()
	fire_missiles()
	silo_sprite.stop()
	spawn_missiles()
	silo_sprite.play()

func spawn_missiles() -> void:
	for i in (num_bullets):
		var missile = bullet_scene.instantiate()
		missile.speed = bullet_speed
		add_child(missile)

func fire_missiles() -> void:
	for child in get_children():
		if (child is PlayerBullet):
			child.launch()
			stagger_missiles_timer.start()
			await stagger_missiles_timer.timeout

func _physics_process(_delta):
	if(!silo_sprite.is_playing() && down_timer.is_stopped()):
		down_timer.start()
