extends RigidBody2D

signal hit

@export var speed = 400
@onready var background = get_parent().get_node("background")

var min_coord
var max_coord
var direction = Vector2.ZERO

func _ready():
	var background_sprite = background as Sprite2D
	var background_texture = background_sprite.texture
	var background_size = background_texture.get_size() * background_sprite.scale
	var background_pos = background_sprite.position

	min_coord = background_pos - background_size/2
	max_coord = background_pos + background_size/2

func _physics_process(_delta):
	linear_velocity = direction * speed
	direction = lerp(direction, Vector2.ZERO, 0.01)
	position = position.clamp(min_coord, max_coord)


func _on_body_entered(_body):
	# disable player collision
	# hide()
	hit.emit()
	# Must be deferred as we can't change physics properties on a physics callback.
	$CollisionShape2D.set_deferred("disabled", true)
