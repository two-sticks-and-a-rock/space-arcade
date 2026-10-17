extends CanvasLayer

var allow_input = true

func _ready():
	EventBus.restart_game.connect(_on_restart)
	EventBus.game_over.connect(_on_game_over)
	EventBus.switch_scenes.connect(_on_switch_scenes)
	visible = false

func _on_switch_scenes(sceneType: EventBus.SceneType) -> void:
	visible = false
	if (sceneType == EventBus.SceneType.MENU):
		allow_input = false
	else:
		allow_input = true

func _on_game_over():
	allow_input = false

func _on_restart():
	visible = false
	get_tree().paused = false
	allow_input = true

func unpause():
	visible = !visible
	get_tree().paused = !get_tree().paused

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("pause") && allow_input:
		unpause()

func _on_continue_run_button_pressed() -> void:
	unpause()
