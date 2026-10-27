extends PlayerBullet

var speed = Vector2(200, 0.0)
var target : CharacterBody2D = null
var target_position : Vector2 = Vector2.ZERO

@onready var detector : RayCast2D = $RayCast2D
var launched : bool = false

func _physics_process(delta: float) -> void:
	if (detector.is_colliding() && target == null):
		var colliding_with = detector.get_collider()
		if (colliding_with != null):
			if !(colliding_with.is_marked):
				colliding_with.is_marked = true
				target = colliding_with
				target_position = target.global_position

	if (target == null):
		rotate(.05)
		$AnimatedSprite2D/Sprite2D.visible = false
	else:
		$AnimatedSprite2D/Sprite2D.visible = true
		global_position = lerp(global_position, target_position, .01)
		if abs((global_position-target_position).length()) < 0.1:
			target = null
			target_position = Vector2.ZERO
	
	if abs((position - Vector2.ZERO).length()) > 0.1:
		launched = true
	if launched:
		global_position -= Mover.get_movement()*delta

	

func _on_missile_entered(body: Node2D) -> void:
	if (body.is_in_group("enemy")):
		body.take_damage(weapon.dmg)
		queue_free()
	
