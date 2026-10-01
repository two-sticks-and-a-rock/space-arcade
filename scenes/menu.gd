extends CanvasLayer

@onready var main = get_parent()

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("pause"):
		visible = !visible
		get_tree().paused = !get_tree().paused

func _on_restart_button_pressed():
	main.free_enemies()
