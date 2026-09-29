extends CharacterBody2D

@onready var player = get_parent().get_parent().get_node("%player") as Node2D

var speed = Vector2(randf_range(250.0, 300.0), 0.0)
func _ready():
	var mob_types = Array($AnimatedSprite2D.sprite_frames.get_animation_names())
	$AnimatedSprite2D.animation = mob_types[0]
	$AnimatedSprite2D.play()

func _physics_process(_delta):
	look_at(player.global_position)
	velocity = speed.rotated(rotation)
	move_and_slide()
