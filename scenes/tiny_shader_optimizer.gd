extends Node2D

@onready var sparks_mat : Resource = preload("res://scenes/sparks_material.tres")
@onready var engine_pulse_mat : Resource = preload("res://scenes/player/player_engine_particles.tres")

func force_load_particles(particles: Resource):
	var particles_instance = GPUParticles2D.new()
	particles_instance.process_material = particles
	particles_instance.one_shot = true
	particles_instance.emitting = true
	add_child(particles_instance)

func _ready():
	force_load_particles(sparks_mat)
	force_load_particles(engine_pulse_mat)

func _on_free_timer_timeout():
	queue_free()
