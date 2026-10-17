extends Button

@onready var main_menu_scene : PackedScene = load("res://scenes/ui/main_menu.tscn")

func _on_main_menu_pressed():
    get_tree().change_scene_to_packed(main_menu_scene)
    get_tree().paused = false

    EventBus.switch_scenes.emit(EventBus.SceneType.MENU)