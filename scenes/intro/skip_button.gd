extends Button

@onready var level_scene : PackedScene = load("res://scenes/main.tscn")

func _on_skip_button_pressed():
	get_tree().change_scene_to_packed(level_scene)
