extends CanvasLayer

@onready var speed_debug = $speed_debug as CanvasLayer
@onready var linear_checkbutton = $speed_debug/linear_checkbox as CheckButton
@onready var linear_base = $speed_debug/linear_checkbox/linear_base as TextEdit
@onready var linear_mult = $speed_debug/linear_checkbox/linear_multiplier as TextEdit

@onready var sqrt_checkbutton = $speed_debug/sqrt_checkbox as CheckButton
@onready var sqrt_base = $speed_debug/sqrt_checkbox/sqrt_base as TextEdit
@onready var sqrt_mult = $speed_debug/sqrt_checkbox/sqrt_multiplier as TextEdit

@onready var pow_checkbutton = $speed_debug/pow_checkbox as CheckButton
@onready var pow_base = $speed_debug/pow_checkbox/pow_base as TextEdit
@onready var pow_mult = $speed_debug/pow_checkbox/pow_multiplier as TextEdit
@onready var pow_power = $speed_debug/pow_checkbox/pow_power as TextEdit

func _ready():
	speed_debug.visible = visible
	linear_base.text = str(SpeedCalc.linear_base_speed)
	linear_mult.text = str(SpeedCalc.linear_speed_multiplier)

	sqrt_base.text = str(SpeedCalc.sqrt_base_speed)
	sqrt_mult.text = str(SpeedCalc.sqrt_speed_multiplier)

	pow_base.text = str(SpeedCalc.pow_base_speed)
	pow_power.text = str(SpeedCalc.pow_power)
	pow_mult.text = str(SpeedCalc.pow_speed_multiplier)
	
	linear_checkbutton.button_pressed = true

func _input(_event: InputEvent) -> void:
	if Input.is_action_pressed("pause"):
		visible = !visible
		speed_debug.visible = visible
		get_tree().paused = !get_tree().paused

func _on_quit_pressed():
	get_tree().quit()

func _on_restart_pressed():
	get_tree().reload_current_scene()

func fallback_to_default(textedit: TextEdit, default: int):
	if (textedit.text.is_valid_int()):
		return textedit.text.to_int()
	else:
		linear_base.text = str(default)
		return default

func _on_save():
	if (linear_checkbutton.button_pressed):
		SpeedCalc.speed_calc = SpeedCalc.speed_calc_options.LINEAR
		SpeedCalc.linear_base_speed = fallback_to_default(linear_base, SpeedCalc.DEFAULTS.get("linear_base_speed"))
		SpeedCalc.linear_speed_multiplier = fallback_to_default(linear_mult, SpeedCalc.DEFAULTS.get("linear_speed_multiplier"))
	if (sqrt_checkbutton.button_pressed):
		SpeedCalc.speed_calc = SpeedCalc.speed_calc_options.SQRT
		SpeedCalc.sqrt_base_speed = fallback_to_default(sqrt_base, SpeedCalc.DEFAULTS.get("sqrt_base_speed"))
		SpeedCalc.sqrt_speed_multiplier = fallback_to_default(sqrt_mult, SpeedCalc.DEFAULTS.get("sqrt_speed_multiplier"))
	if (pow_checkbutton.button_pressed):
		SpeedCalc.speed_calc = SpeedCalc.speed_calc_options.POW
		SpeedCalc.pow_base_speed = fallback_to_default(pow_base, SpeedCalc.DEFAULTS.get("pow_base_speed"))
		SpeedCalc.pow_speed_multiplier = fallback_to_default(pow_mult,  SpeedCalc.DEFAULTS.get("pow_speed_multiplier"))
		SpeedCalc.pow_power = fallback_to_default(pow_power, SpeedCalc.DEFAULTS.get("pow_power"))
