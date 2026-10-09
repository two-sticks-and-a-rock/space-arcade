extends CanvasLayer

@onready var main = get_parent()

var prevent_input = false

func _ready():
	EventBus.level_up.connect(_on_player_level_up)
	EventBus.finish_level_up.connect(_on_player_finish_level_up)
	EventBus.restart_game.connect(_on_restart_button_pressed)

func _input(_event: InputEvent) -> void:
	if (prevent_input): 
		return
	
	if Input.is_action_just_pressed("pause"):
		visible = !visible
		get_tree().paused = !get_tree().paused

func _on_player_level_up():
	prevent_input = true

func _on_player_finish_level_up():
	prevent_input = false

func _on_restart_button_pressed():
	main.free_enemies()
