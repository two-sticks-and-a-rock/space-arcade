extends CharacterBody2D

@onready var player = get_parent().get_node("%player") as StaticBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var sparks: GPUParticles2D = $sparks

@export var xp_scene : PackedScene
@export var explosion : PackedScene

var speed = Vector2(randf_range(250.0, 300.0), 0.0)
var speed_mod : float = 1.0
var max_hp = 40
var curr_hp = max_hp

@onready var freeze_timer : Timer = Timer.new()
var is_frozen: bool = false
var is_marked: bool = false

var just_shoved: bool = false
var shove_velocity: Vector2 = Vector2.ZERO

func set_shader_intensity(newValue: float): 
	animated_sprite_2d.material.set_shader_parameter("blink_intensity", newValue)

func take_damage(dmg: int):
	curr_hp -= dmg
	
	var tween = get_tree().create_tween()
	tween.tween_method(set_shader_intensity, 1.0, 0.0, 0.5)
	sparks.restart()
	sparks.emitting = true
	
	if (curr_hp <= 0):
		var drop_xp = func():
			var xp_drop = xp_scene.instantiate()
			xp_drop.global_position = global_position
			get_parent().add_child(xp_drop)
		drop_xp.call_deferred()
		EventBus.enemy_death.emit()
		
		var explode = func():
			var _explosion = explosion.instantiate()
			_explosion.position = global_position
			_explosion.rotation = global_rotation
			_explosion.emitting = true
			get_parent().add_child(_explosion)
		explode.call_deferred()
		queue_free()
		
		

func freeze(time: int):
	if not is_frozen:
		animated_sprite_2d.material.set_shader_parameter("status_intensity", 1.0)
		is_frozen = true
		speed = Vector2.ZERO
		freeze_timer.start(time)
		await freeze_timer.timeout
		speed = Vector2(randf_range(250.0, 300.0), 0.0)
		is_frozen = false
		animated_sprite_2d.material.set_shader_parameter("status_intensity", 0.0)

func _ready():
	freeze_timer.one_shot = true
	add_child(freeze_timer)
	var ram_scene = load("res://scenes/enemies/enemy_weapons/ram.tscn") as PackedScene
	var ram_weapon = ram_scene.instantiate() as Area2D
	ram_weapon.set_collision_rectangle((($CollisionShape2D as CollisionShape2D).shape as RectangleShape2D).size + Vector2(3, 3))

	add_child(ram_weapon)

	var mob_types = Array($AnimatedSprite2D.sprite_frames.get_animation_names())
	$AnimatedSprite2D.animation = mob_types[0]
	$AnimatedSprite2D.play()
	
	set_enemy_class()

func set_enemy_class() -> void:
	var enemy_class: int = randi_range(0, 4)
	if enemy_class == 3:
		$AnimatedSprite2D.frame = 1
		max_hp = 60
		curr_hp = max_hp
		speed_mod = 0.8
		scale = Vector2(1.2, 1.2)
	if enemy_class == 4:
		$AnimatedSprite2D.frame = 2
		max_hp = 20
		curr_hp = max_hp
		speed_mod = 1.2
		scale = Vector2(0.8, 0.8)

func _physics_process(_delta):
	if !is_frozen:
		look_at(player.position)
	velocity = speed.rotated(rotation) * speed_mod

	if just_shoved:
		velocity = shove_velocity
		just_shoved = false
	
	if (abs((shove_velocity-Vector2.ZERO).length()) >= 0.001):
		shove_velocity = Utils.exp_velocity_decay(shove_velocity, Vector2.ZERO, 0.1)
		velocity = shove_velocity
	else:
		shove_velocity = Vector2.ZERO

	velocity -= Mover.get_movement()
	move_and_slide()

func shove_enemy(new_velocity: Vector2):
	just_shoved = true
	shove_velocity = new_velocity

func _on_screen_exited():
	queue_free()
