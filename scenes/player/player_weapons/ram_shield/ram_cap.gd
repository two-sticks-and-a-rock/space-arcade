extends PlayerBullet


func _ready():
	bullet_scale = Vector2.ONE*1.5

	super()

func _physics_process(_delta):
	sprite.look_at(-1*get_global_mouse_position())

func _on_ram_cap_entered(body: Node2D):
	if (body.is_in_group("enemy")):
		var enemy = body as CharacterBody2D
		enemy.shove_enemy(-2*enemy.velocity)
		body.take_damage(weapon.dmg)

func detonate():
	collider.scale += 1*Vector2.ONE
	var enemies = get_overlapping_bodies().filter(func(body):
		return body is CharacterBody2D)
	for body in enemies:
		var enemy = body as CharacterBody2D
		enemy.shove_enemy(-4*enemy.velocity)
		enemy.take_damage(weapon.dmg)
	collider.scale -= 1*Vector2.ONE
	
