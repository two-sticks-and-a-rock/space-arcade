extends Node

enum speed_calc_options {
	LINEAR,
	SQRT,
	POW
}

var DEFAULTS = {
	"speed_calc": speed_calc_options.LINEAR,

	"linear_base_speed": 0,
	"linear_speed_multiplier": 1,

	"sqrt_base_speed": 0,
	"sqrt_speed_multiplier": 1,

	"pow_base_speed": 0,
	"pow_power": 2,
	"pow_speed_multiplier": 1,
}

var speed_calc = DEFAULTS.get("speed_calc")

var linear_base_speed = DEFAULTS.get("linear_base_speed")
var linear_speed_multiplier = DEFAULTS.get("linear_speed_multiplier")

var sqrt_base_speed = DEFAULTS.get("sqrt_base_speed")
var sqrt_speed_multiplier = DEFAULTS.get("sqrt_speed_multiplier")

var pow_base_speed = DEFAULTS.get("pow_base_speed")
var pow_power = DEFAULTS.get("pow_power")
var pow_speed_multiplier = DEFAULTS.get("pow_speed_multiplier")