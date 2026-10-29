extends Node2D

@onready var engine_pulse_1: GPUParticles2D = $engine_pulse1
@onready var engine_pulse_2: GPUParticles2D = $engine_pulse2
@onready var engine_pulse_3: GPUParticles2D = $engine_pulse3
@onready var engine_pulse_4: GPUParticles2D = $engine_pulse4

func _on_engine_burn() -> void:
	engine_pulse_1.restart()
	engine_pulse_1.emitting = true
	engine_pulse_2.restart()
	engine_pulse_2.emitting = true
	engine_pulse_3.restart()
	engine_pulse_3.emitting = true
	engine_pulse_4.restart()
	engine_pulse_4.emitting = true
