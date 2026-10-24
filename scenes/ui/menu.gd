extends CanvasLayer

var allow_input : bool = true
var is_leveling_up : bool = true

func _ready():
	EventBus.level_up.connect(_on_player_level_up)
	EventBus.finish_level_up.connect(_on_player_finish_level_up)

	EventBus.get_starting_weapon.connect(_on_player_level_up)
	EventBus.start_tutorial.connect(_on_player_finish_level_up)

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

func _on_game_over(_game_over_data: EventBus.GameOverData):
	allow_input = false

func _on_restart():
	visible = false
	get_tree().paused = false
	allow_input = true

func _on_player_level_up():
	is_leveling_up = true

func _on_player_finish_level_up():
	is_leveling_up = false
	
func unpause():
	visible = !visible
	if (!is_leveling_up):
		get_tree().paused = !get_tree().paused

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("pause") && allow_input:
		unpause()

func _on_continue_run_button_pressed() -> void:
	unpause()
