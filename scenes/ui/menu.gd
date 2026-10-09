extends CanvasLayer

var allow_input = true

func _ready():
	EventBus.restart_game.connect(_on_restart)
	EventBus.game_over.connect(_on_game_over)
	visible = false

func _on_game_over():
	allow_input = false

func _on_restart():
	visible = false
	get_tree().paused = false
	allow_input = true

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("pause") && allow_input:
		visible = !visible
		get_tree().paused = !get_tree().paused
