extends PlayerBullet

func _ready():
	bullet_scale = Vector2.ONE*1.5

	super()

func _physics_process(_delta):
	sprite.look_at(-1*get_global_mouse_position())

func _on_ram_cap_entered(body: Node2D):
	if (body.is_in_group("enemy")):
		var cast_body = body as CharacterBody2D
		cast_body.shove_enemy(-2*cast_body.velocity)
		body.take_damage(weapon.dmg)
		(get_parent() as PlayerWeapon).steal_life()
