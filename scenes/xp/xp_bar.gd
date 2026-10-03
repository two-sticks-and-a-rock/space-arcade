extends ProgressBar

var xp_threshold : int = 5

@onready var viewport_width = get_viewport().size.x
@onready var level_up_debug : Label = $LevelUpDebug

var curr_xp : int = 0
var step_mult : int = 0

func _ready():
	level_up_debug.visible = false

	max_value = viewport_width
	value = 0
	step_mult = get_visible_step_mult()

func _physics_process(delta):
	position -= Mover.get_movement()*delta
	position = lerp(position, Vector2.ZERO, 0.1)

	value = curr_xp * step_mult

func get_next_xp_threshold() -> int:
	return xp_threshold * 2

func handle_level_up():
	curr_xp -= max(xp_threshold, 0)

	xp_threshold = get_next_xp_threshold()
	step_mult = get_visible_step_mult()

	level_up_debug.visible = true
	wait.call_deferred(4)

func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout
	level_up_debug.visible = false

func gain_xp(xp: int):
	curr_xp += xp
	if (curr_xp >= xp_threshold):
		handle_level_up.call_deferred()

func get_visible_step_mult() -> int:
	# TODO: this might have rounding issues if we're not careful 
	# Also we have viewport width pinned right now, that might not be true later
	return viewport_width / xp_threshold
