class_name PlayerBullet
extends Area2D

@onready var weapon: PlayerWeapon = get_parent() as PlayerWeapon
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collider: CollisionShape2D = $CollisionShape2D

var bullet_scale: Vector2 = Vector2.ONE

func _ready():
	sprite.scale = bullet_scale
	collider.scale = bullet_scale

func _scale_bullet(new_scale: Vector2):
	bullet_scale = new_scale

func _on_orbiter_entered(body: Node2D):
	if (body.is_in_group("enemy")):
		body.take_damage(weapon.dmg)
