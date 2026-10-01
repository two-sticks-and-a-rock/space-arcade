extends Area2D


var dmg = 50
var spin_speed = PI/36

func _physics_process(_delta):
	position = Vector2(position).rotated(spin_speed)

func _on_orbiter_entered(body: Node2D):
	if ("take_damage" in body):
		body.take_damage(dmg)