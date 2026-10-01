extends CharacterBody2D

@onready var player = get_parent().get_node("%player") as StaticBody2D

var xp_value = 1
var xp_scene_path : Dictionary = XpValueToFileMap.xp_to_scene_file[1]
var xp_scene : PackedScene = null

var speed = Vector2(randf_range(250.0, 300.0), 0.0)
var max_hp = 40
var curr_hp = max_hp

func take_damage(dmg: int):
	curr_hp -= dmg
	if (curr_hp <= 0):
		var drop_xp = func():
			var xp_drop = xp_scene.instantiate()
			xp_drop.global_position = global_position
			get_parent().add_child(xp_drop)
		drop_xp.call_deferred()

		queue_free()

func _ready():
	xp_scene = load(xp_scene_path["location"])

	var ram_scene = load("res://scenes/enemies/enemy_weapons/ram.tscn") as PackedScene
	var ram_weapon = ram_scene.instantiate() as Area2D
	ram_weapon.set_collision_radius((($CollisionShape2D as CollisionShape2D).shape as CircleShape2D).radius + 3)

	add_child(ram_weapon)

	var mob_types = Array($AnimatedSprite2D.sprite_frames.get_animation_names())
	$AnimatedSprite2D.animation = mob_types[0]
	$AnimatedSprite2D.play()


func _physics_process(_delta):
	look_at(player.position)
	velocity = speed.rotated(rotation)
	velocity -= Mover.get_movement()
	move_and_slide()
