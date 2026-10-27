extends PlayerBullet

var original_position : Vector2

func _ready():
	$AnimatedSprite2D.frame = randi_range(0, 3)

func toggle_visibility(on: bool) -> void:
	visible = on
	process_mode = Node.PROCESS_MODE_INHERIT if on == true else  Node.PROCESS_MODE_DISABLED

func _on_orbiter_entered(body: Node2D):
	if (body.is_in_group("enemy")):
		body.take_damage(weapon.dmg)
		var cast_body = body as CharacterBody2D
		cast_body.shove_enemy(-4*cast_body.velocity)