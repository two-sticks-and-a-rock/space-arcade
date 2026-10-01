extends Area2D

@onready var player = get_parent().get_node("%player") as StaticBody2D

func _physics_process(delta):
	position -= Mover.get_movement() * delta

func _on_gear_entered(body: Node2D):
	if (body.name == "player"):
		# TODO: increase player XP
		queue_free()		
