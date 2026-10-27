extends PlayerBullet

# TODO: this is hacky. It's here because the asteroid png is slightly bigger than we want
var scale_for_sprite = 0.5

func _ready():
	$AnimatedSprite2D.frame = randi_range(0, 3)

func _physics_process(_delta):
	position = Vector2(position).rotated(weapon.bullet_speed)

func _on_orbiter_entered(body: Node2D):
	if (body.is_in_group("enemy")):
		body.take_damage(weapon.dmg)
		var cast_body = body as CharacterBody2D
		cast_body.shove_enemy(-2*cast_body.velocity)