extends Button

@onready var level_scene : PackedScene = load("res://scenes/intro/intro.tscn")

func _on_start_pressed():
	get_tree().change_scene_to_packed(level_scene)
	EventBus.switch_scenes.emit(EventBus.SceneType.LEVEL)
	Sfx.play("UI_positive")
	
