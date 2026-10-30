extends PlayerBullet

var speed = 0
var target : CharacterBody2D = null
var target_position : Vector2 = Vector2.ZERO

@onready var detector : RayCast2D = $RayCast2D
@export var explosion : PackedScene
var launched : bool = false

var detonation_timer : Timer = Timer.new()

func _ready():
	global_rotation = randf_range(-PI / 4, PI / 4)
	$AnimatedSprite2D.visible = false
	detonation_timer.one_shot = true
	detonation_timer.wait_time = 5.0
	detonation_timer.timeout.connect(_on_detonation_timer_timeout)
	add_child(detonation_timer)

func launch():
	launched = true
	detonation_timer.start()
	$AnimatedSprite2D.visible = true

func seek():
	global_rotation += 0.05

	if (detector.is_colliding() && target == null):
		var colliding_with = detector.get_collider()
		if (colliding_with != null):
			if !(colliding_with.is_marked):
				colliding_with.is_marked = true
				target = colliding_with
				target_position = target.global_position

func explode():
		var _explosion = explosion.instantiate()
		_explosion.position = global_position
		_explosion.rotation = global_rotation
		get_parent().add_child(_explosion)

func _on_detonation_timer_timeout():
	explode.call_deferred()
	Sfx.play("enemy_death")
	queue_free()

func _physics_process(delta: float) -> void:
	if target == null:
		# start seeking a target
		seek()

	if !launched && target != null:
		# keep tracking target until launch
		look_at(target_position)

	if launched:
		if target != null:
			# launch to target
			global_position = global_position.move_toward(target.global_position, speed * delta)
			if abs((global_position-target_position).length()) < 0.1:
				target = null
				target_position = Vector2.ZERO
		else:
			# launch with no target
			global_position += global_transform.x * speed * delta
		global_position -= Mover.get_movement()*delta

func _on_missile_entered(body: Node2D) -> void:
	if (body.is_in_group("enemy")):
		body.take_damage(weapon.dmg)
		explode.call_deferred()
		Sfx.play("enemy_death")
		queue_free()
		
	
