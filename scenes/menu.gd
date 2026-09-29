extends CanvasLayer

func _ready():
	pass # Replace with function body.
@onready var main = get_parent()

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("pause"):
		visible = !visible
		get_tree().paused = !get_tree().paused

func _on_quit_pressed():
	main.free_enemies()
	get_tree().quit()

func _on_restart_pressed():
	Mover.reset()
	main.free_enemies()
	get_tree().paused = false
	get_tree().reload_current_scene()