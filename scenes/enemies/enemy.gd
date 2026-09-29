extends CharacterBody2D

@onready var player = get_parent().get_node("%player") as StaticBody2D

var speed = Vector2(randf_range(250.0, 300.0), 0.0)

func _ready():
	var mob_types = Array($AnimatedSprite2D.sprite_frames.get_animation_names())
	$AnimatedSprite2D.animation = mob_types[0]
	$AnimatedSprite2D.play()

func _physics_process(_delta):
	look_at(player.position)
	velocity = speed.rotated(rotation)
	velocity -= Mover.get_movement()
	move_and_slide()
