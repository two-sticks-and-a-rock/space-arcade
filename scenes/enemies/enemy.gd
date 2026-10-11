extends CharacterBody2D

@onready var player = get_parent().get_node("%player") as StaticBody2D

var xp_value = Xp.GEAR_VALUE
var xp_scene_path : Dictionary = Xp.xp_to_scene_file[xp_value]
var xp_scene : PackedScene = null

var speed = Vector2(randf_range(250.0, 300.0), 0.0)
var max_hp = 40
var curr_hp = max_hp

@onready var freeze_timer : Timer = Timer.new()
var is_frozen: bool = false

func take_damage(dmg: int):
	curr_hp -= dmg
	if (curr_hp <= 0):
		var drop_xp = func():
			var xp_drop = xp_scene.instantiate()
			xp_drop.global_position = global_position
			get_parent().add_child(xp_drop)
		drop_xp.call_deferred()
		queue_free()

func freeze(time: int = 5):
	if not is_frozen:
		modulate = Color.AQUA
		is_frozen = true
		speed = Vector2.ZERO
		freeze_timer.start(time)
		await freeze_timer.timeout
		speed = Vector2(randf_range(250.0, 300.0), 0.0)
		is_frozen = false
		modulate = Color.WHITE

func _ready():
	freeze_timer.one_shot = true
	add_child(freeze_timer)
	xp_scene = load(xp_scene_path["location"])

	var ram_scene = load("res://scenes/enemies/enemy_weapons/ram.tscn") as PackedScene
	var ram_weapon = ram_scene.instantiate() as Area2D
	ram_weapon.set_collision_rectangle((($CollisionShape2D as CollisionShape2D).shape as RectangleShape2D).size + Vector2(3, 3))

	add_child(ram_weapon)

	var mob_types = Array($AnimatedSprite2D.sprite_frames.get_animation_names())
	$AnimatedSprite2D.animation = mob_types[0]
	$AnimatedSprite2D.play()


func _physics_process(_delta):
	look_at(player.position)
	velocity = speed.rotated(rotation)
	velocity -= Mover.get_movement()
	move_and_slide()
