class_name PlayerBullet
extends Area2D

@onready var weapon = get_parent()

func _on_orbiter_entered(body: Node2D):
	if ("take_damage" in body):
		body.take_damage(weapon.dmg)