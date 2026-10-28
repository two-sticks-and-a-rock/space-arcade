extends ColorRect

var scroll_x = 0.0
var scroll_y = 0.0

func _physics_process(delta: float) -> void:
	scroll_x += delta*250
	scroll_y += delta*250
	material.set_shader_parameter("offset", Vector2(scroll_x, scroll_y))
