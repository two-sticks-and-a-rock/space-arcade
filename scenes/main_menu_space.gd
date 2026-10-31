extends ColorRect

@export var scroll_x: float = 0.0
@export  var scroll_y: float = 0.0

@export var x_speed :float = 250
@export var y_speed :float = 250

func _physics_process(delta: float) -> void:
	scroll_x += delta*x_speed
	scroll_y += delta*y_speed
	material.set_shader_parameter("offset", Vector2(scroll_x, scroll_y))
