extends Area2D

@onready var orbiter_ring = get_parent()

func _physics_process(_delta):
	position = Vector2(position).rotated(orbiter_ring.bullet_speed)

func _on_orbiter_entered(body: Node2D):
	if ("take_damage" in body):
		body.take_damage(orbiter_ring.dmg)