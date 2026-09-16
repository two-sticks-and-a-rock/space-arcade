extends RigidBody2D

signal hit

@export var speed = 400
var screen_size
var direction = Vector2.ZERO

func _ready():
	screen_size = get_viewport_rect().size

# func _process(delta):
# 	var velocity = direction
# 	# if Input.is_action_pressed("move_right"):
# 	# 	velocity.x += 1
# 	# if Input.is_action_pressed("move_left"):
# 	# 	velocity.x -= 1
# 	# if Input.is_action_pressed("move_back"):
# 	# 	velocity.y += 1
# 	# if Input.is_action_pressed("move_forward"):
# 	# 	velocity.y -= 1

# 	if velocity.length() > 0:
# 		velocity = velocity.normalized() * speed

# 	position += velocity * delta
# 	position = position.clamp(Vector2.ZERO, screen_size)

func _physics_process(_delta):
	linear_velocity = direction * speed
	direction = lerp(direction, Vector2.ZERO, 0.01)
	# Steering, kind of unwieldy
	# if Input.is_action_pressed("move_right"):
	# 	linear_velocity.x += 1
	# if Input.is_action_pressed("move_left"):
	# 	linear_velocity.x -= 1
	# if Input.is_action_pressed("move_back"):
	# 	linear_velocity.y += 1
	# if Input.is_action_pressed("move_forward"):
	# 	linear_velocity.y -= 1
	# linear_velocity *= speed
	position = position.clamp(Vector2.ZERO, screen_size)

func _on_body_entered(_body):
	print("_on_body_entered")
	# disable player collision
	# hide()
	hit.emit()
	# Must be deferred as we can't change physics properties on a physics callback.
	$CollisionShape2D.set_deferred("disabled", true)