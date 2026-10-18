extends CanvasLayer

@onready var kills_value : Label = $HSplitContainer/HBoxContainer/KillsValue
var total_kills : int = 0
var displayed_zeros : int = 5

@onready var run_time_value : Label = $RunTime
var run_time : float = 0.0

func init_kills_text() -> String:
	var zeros = ""
	for i in displayed_zeros:
		zeros += "0"
	return zeros

func _ready():
	kills_value.text = init_kills_text()
	EventBus.game_over.connect(_on_game_over)
	EventBus.enemy_death.connect(_on_enemy_death)

func _on_game_over(_game_over_data: EventBus.GameOverData):
	visible = false

func get_kills_with_leading_zeros(kills: int) -> String:
	var kills_copy = kills
	var num_nonzeros : int = 0
	while kills_copy > 0:
		num_nonzeros += 1
		kills_copy /= 10
	
	var prepend_zeros = str(kills)
	while num_nonzeros < displayed_zeros:
		num_nonzeros += 1
		prepend_zeros = "0" + prepend_zeros
	
	return prepend_zeros

func _on_enemy_death():
	total_kills += 1
	kills_value.text = get_kills_with_leading_zeros(total_kills)

func float_to_displayed_time(timer_time : float) -> String:
	var minutes : int = int(timer_time / 60.0)
	var seconds : int = int(timer_time) % 60
	var minutes_with_leading_zeros = str(minutes) if minutes > 10 else "0"+str(minutes)
	var seconds_with_leading_zeros = str(seconds) if seconds > 10 else "0"+str(seconds)
	return minutes_with_leading_zeros + ":" + seconds_with_leading_zeros

func _physics_process(delta):
	run_time += delta
	run_time_value.text = float_to_displayed_time(run_time)
