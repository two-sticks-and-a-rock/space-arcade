extends PlayerBullet


func _ready():
	bullet_scale = Vector2.ONE*1.5

	super()

func _physics_process(_delta):
	sprite.look_at(-1*get_global_mouse_position())

func _on_ram_cap_entered(body: Node2D):
	if (body.is_in_group("enemy")):
		if (Mover.slingshot_length_clamp - Mover.get_movement().length()) < 50:
			body.take_damage(weapon.dmg * 2)
		else:
			body.take_damage(weapon.dmg)