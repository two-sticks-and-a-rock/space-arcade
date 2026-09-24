extends RigidBody2D

@onready var player = get_parent().get_node("%player") as RigidBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	var mob_types = Array($AnimatedSprite2D.sprite_frames.get_animation_names())
	$AnimatedSprite2D.animation = mob_types[0]
	$AnimatedSprite2D.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	look_at(player.position)	

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()