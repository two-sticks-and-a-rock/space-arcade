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

<<<<<<< HEAD
func fire_missiles() -> void:
	Sfx.play("missile_launcher")
=======
func _on_missile_down_timer_timeout():
	down_timer.stop()
	fire_missiles()
	silo_sprite.stop()
	spawn_missiles()

func spawn_missiles() -> void:
>>>>>>> aed6a7019e758bce360c6f42962816ee5a0b3e62
	for i in (num_bullets):
		var missile = bullet_scene.instantiate()
		missile.speed = bullet_speed
		add_child(missile)
		
<<<<<<< HEAD
=======
func fire_missiles() -> void:
	Sfx.play("missile_launcher")
	for child in get_children():
		if (is_instance_valid(child)):
			if (child is PlayerBullet):
				child.launch()
				stagger_missiles_timer.start()
				await stagger_missiles_timer.timeout
>>>>>>> aed6a7019e758bce360c6f42962816ee5a0b3e62

func _physics_process(_delta):
	if(!silo_sprite.is_playing() && down_timer.is_stopped()):
		down_timer.start()
		silo_sprite.play()

func play_reload_sound() -> void:
	var step = down_timer.wait_time / 3.0
	Sfx.play_after("missile_reload", step)
