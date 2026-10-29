extends ProgressBar

var xp_threshold : int = 7

@onready var viewport_width = get_viewport().size.x
@onready var level_up_debug = $LevelUpDebug

var curr_xp : int = 0
var step_mult : int = 0

var is_leveling_up = false
var level = 0

func _reset_xp() -> void:
	curr_xp = 0
	step_mult = 0

func _ready():
	EventBus.restart_game.connect(_reset_xp)
	EventBus.finish_level_up.connect(_on_finish_level_up)

	max_value = viewport_width
	value = 0
	set_visible_step_mult()
	level_up_debug.text = "Level: 0. XP to next level: " + str(xp_threshold)

func _physics_process(_delta):
	value = curr_xp * step_mult

func set_next_xp_threshold() -> void:
	level+=1

	if level % 2 == 1:
		xp_threshold *= 2
	level_up_debug.text = "Level: " + str(level) + ". XP to next level: " + str(xp_threshold)

func handle_level_up() -> void:
	curr_xp -= max(xp_threshold, 0)

	EventBus.level_up.emit()

	set_next_xp_threshold()
	set_visible_step_mult()

func gain_xp(xp: int) -> void:
	curr_xp += xp
	if (curr_xp >= xp_threshold && !is_leveling_up):
		is_leveling_up = true
		handle_level_up.call_deferred()

func _on_finish_level_up():
	is_leveling_up = false

func set_visible_step_mult() -> void:
	# TODO: this might have rounding issues if we're not careful 
	# Also we have viewport width pinned right now, that might not be true later
	step_mult = viewport_width / xp_threshold
