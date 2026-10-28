extends Node2D

@onready var sparks_mat : Resource = preload("res://scenes/sparks_material.tres")
@onready var engine_pulse_mat : Resource = preload("res://scenes/player/player_engine_particles.tres")
@onready var enemy_explosion_mat : Resource = preload("res://scenes/enemies/enemy_explosion.tres")
@onready var explosion_scatter_bubbles_mat : Resource = preload("res://scenes/vfx/explopsion_scatter_bubbles.tres")
@onready var explosion_main_sphere_mat : Resource = preload("res://scenes/vfx/explopsion_main_sphere.tres")

@onready var enemy_blink_shader : Resource = preload("res://scenes/enemies/enemy_shader.tres")
@onready var player_blink_shader : Resource = preload("res://scenes/player/player_blink_shader.tres")

func force_load_particles(particles: Resource):
	var particles_instance = GPUParticles2D.new()
	particles_instance.process_material = particles
	particles_instance.one_shot = true
	particles_instance.emitting = true
	add_child(particles_instance)

func force_load_shaders(shader: Resource):
	var color_rect = ColorRect.new()
	color_rect.material = shader

func _ready():
	force_load_particles(sparks_mat)
	force_load_particles(engine_pulse_mat)
	force_load_particles(enemy_explosion_mat)
	force_load_particles(explosion_scatter_bubbles_mat)
	force_load_particles(explosion_main_sphere_mat)

	force_load_shaders(enemy_blink_shader)
	force_load_shaders(player_blink_shader)

func _on_free_timer_timeout():
	queue_free()
