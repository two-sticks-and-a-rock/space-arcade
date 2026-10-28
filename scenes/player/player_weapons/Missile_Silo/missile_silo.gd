extends PlayerWeapon

@onready var silo_sprite : AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	super()
	silo_sprite.play()

	# Use the down timer to decide how fast the animation is
	silo_sprite.sprite_frames.set_animation_speed("default", 3/down_timer.wait_time)

func fire_missiles() -> void:
	for i in (num_bullets):
		var missile = bullet_scene.instantiate()
		missile.rotate(randf_range(-PI / 4, PI / 4))
		missile.speed = Vector2(bullet_speed, 0)
		add_child(missile)

func _physics_process(_delta):
	if !silo_sprite.is_playing():
		fire_missiles.call_deferred()
		silo_sprite.play()
