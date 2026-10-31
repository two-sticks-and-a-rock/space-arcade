extends PlayerBullet

var original_position : Vector2

func _ready():
	$AnimatedSprite2D.frame = randi_range(0, 3)
	sprite.scale = bullet_scale
	collider.scale = bullet_scale

func toggle_visibility(on: bool) -> void:
	visible = on
	process_mode = Node.PROCESS_MODE_INHERIT if on == true else  Node.PROCESS_MODE_DISABLED

func set_bullet_scale(bullet_size: float):
	bullet_scale = Vector2(bullet_size, bullet_size)*0.5

func set_scale_for_animation(new_scale: Vector2):
	sprite.scale = new_scale
	collider.scale = new_scale

func get_current_scale():
	return sprite.scale

func _on_orbiter_entered(body: Node2D):
	if (body.is_in_group("enemy")):
		body.take_damage(weapon.dmg)
		var cast_body = body as CharacterBody2D
		cast_body.shove_enemy(-4*cast_body.velocity)
