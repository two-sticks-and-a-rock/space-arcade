class_name Player
extends StaticBody2D

@export var orbiter_ring_scene : PackedScene
@export var frost_nova_scene : PackedScene
@export var missile_silo_scene : PackedScene
@export var ram_shield_scene : PackedScene

@onready var hp_bar : ProgressBar = $hp
@onready var xp_bar : ProgressBar = $Hud/XpBar
@onready var magnet_collider : CollisionShape2D = $XpMagnet/CollisionShape2D
@onready var sprite : Sprite2D = $Sprite2D
@onready var sprite_2d: Sprite2D = $Sprite2D/Sprite2D
@onready var sparks: GPUParticles2D = $sparks

@onready var hud : CanvasLayer = $Hud

var max_hp : int = 500
var curr_hp : int = max_hp
var magnet_radius : int = 400

var immune_to_damage : bool = false

func _ready():
	EventBus.finish_level_up.connect(handle_finish_level_up)
	hp_bar.max_value = max_hp
	hp_bar.value = max_hp

	# var orbiter_ring = orbiter_ring_scene.instantiate() as Node2D
	# add_child(orbiter_ring)
	# var frost_nova = frost_nova_scene.instantiate() as Node2D
	# add_child(frost_nova)
	# var ram_shield = ram_shield_scene.instantiate() as Node2D
	# add_child(ram_shield)
	(magnet_collider.shape as CircleShape2D).radius = magnet_radius
	# var missile_silo = missile_silo_scene.instantiate() as Node2D
	# add_child(missile_silo)

func handle_finish_level_up():
	curr_hp += ceil(max_hp * 0.1)

# for blinking on taking damage
func set_shader_intensity(newValue: float): 
	sprite_2d.material.set_shader_parameter("blink_intensity", newValue)

func take_damage(dmg: int):
	if immune_to_damage:
		return
	curr_hp -= dmg
	Sfx.play("player_damaged")
	
	# blink tween and kick off animation for sparks
	var tween = get_tree().create_tween()
	tween.tween_method(set_shader_intensity, 1.0, 0.0, 0.5)
	sparks.restart()
	sparks.emitting = true

func heal_damage(dmg: int):
	var overheal = (curr_hp + dmg) - max_hp
	if (overheal > 0):
		curr_hp = max_hp
		#print("Overhealed " + str(overheal))
	else:
		curr_hp += dmg

func gain_xp(xp: int):
	xp_bar.gain_xp(xp)

func handle_game_over():
	EventBus.game_over.emit(EventBus.GameOverData.new(
		hud.total_kills,
		hud.kills_value.text,
		hud.run_time,
		hud.run_time_value.text,
	))

func _physics_process(_delta):
	sprite.look_at(-1*get_global_mouse_position())
		
	hp_bar.value = curr_hp
	if (curr_hp <= 0):
		handle_game_over.call_deferred()

	constant_linear_velocity = Mover.get_movement()
