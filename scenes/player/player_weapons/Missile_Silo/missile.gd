extends PlayerBullet

var speed = Vector2(200, 0.0)
var target : CharacterBody2D = null

@onready var detector : RayCast2D = $RayCast2D

func _physics_process(delta: float) -> void:
	if (detector.is_colliding() && target == null):
		var colliding_with = detector.get_collider()
		if (colliding_with != null):
			if !(colliding_with.is_marked):
				colliding_with.is_marked = true
				target = colliding_with
			
	if (target == null):
		rotate(.05)
	else:
		global_position = lerp(global_position, target.global_position, .01)
		global_rotation = rotate_toward(global_rotation, get_angle_to(target.global_position), 0.1)
	global_position -= Mover.get_movement()*delta
	

func _on_missile_entered(body: Node2D) -> void:
	if (body.is_in_group("enemy")):
		body.take_damage(weapon.dmg)
		queue_free()
	
