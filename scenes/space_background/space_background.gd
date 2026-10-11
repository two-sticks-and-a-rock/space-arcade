extends ColorRect

var scroll_x = 0.0
var scroll_y = 0.0

func _physics_process(delta: float) -> void:
	scroll_x += Mover.get_movement().x * delta
	scroll_y += Mover.get_movement().y * delta
	material.set_shader_parameter("offset", Vector2(scroll_x, scroll_y))
	print(material.get_shader_parameter("offset"))
