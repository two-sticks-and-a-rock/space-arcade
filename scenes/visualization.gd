extends Line2D


@onready var slingshot = get_parent() as Line2D
@onready var player = get_parent().get_parent() as RigidBody2D

var start_vector := Vector2.ZERO
var end_vector := Vector2.ZERO

# func _ready():

func _process(_delta):
	if (Input.is_action_pressed("click")):
		end_vector = start_vector + (slingshot.points[0] - slingshot.points[1])		
		remove_point(1)
		remove_point(0)

		add_point(start_vector)
		add_point(end_vector)
	if (Input.is_action_just_released("click")):
		remove_point(1)
		remove_point(0)
	