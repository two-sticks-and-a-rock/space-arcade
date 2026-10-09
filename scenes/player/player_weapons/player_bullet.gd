class_name PlayerBullet
extends Area2D

@onready var weapon: PlayerWeapon = get_parent()
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D

var bullet_scale: Vector2 = Vector2.ONE

func _scale_bullet(new_scale: Vector2):
	sprite.scale = new_scale
	collision_shape.scale = new_scale

func _ready():
	_scale_bullet(bullet_scale)

	
func _on_orbiter_entered(body: Node2D):
	if ("take_damage" in body):
		body.take_damage(weapon.dmg)
