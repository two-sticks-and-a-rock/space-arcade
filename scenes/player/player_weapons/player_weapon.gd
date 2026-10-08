class_name PlayerWeapon
extends Node2D

@export var dmg: int
@export var bullets: int
@export var bullet_speed: float

@onready var up_timer : Timer = $UpTimer as Timer
@onready var down_timer : Timer = $DownTimer as Timer

func _on_down_timer_timeout():
	up_timer.start()
	down_timer.stop()
	visible = true

func _on_up_timer_timeout():
	down_timer.start()
	up_timer.stop()
	visible = false