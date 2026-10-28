extends Node2D

# NOTE: if performance becomes an issue, turn off the sparks emitter first 
# as it's the least important layer.

@onready var main_multi_spheres: GPUParticles2D = $main_multi_spheres
@onready var main_explosion_bubble: GPUParticles2D = $"main explosion bubble"
@onready var warped_bubbles: GPUParticles2D = $"warped bubbles"
@onready var small_bubbles: GPUParticles2D = $"small bubbles"
@onready var sparks: GPUParticles2D = $sparks
@onready var warped_bubbles_2: GPUParticles2D = $"warped bubbles2"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# turn on the child emitters
	main_multi_spheres.emitting = true
	main_explosion_bubble.emitting = true
	warped_bubbles.emitting = true
	small_bubbles.emitting = true
	sparks.emitting = true
	warped_bubbles_2.emitting = true
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# need this to stop the particles at end and make sure they get freed up. 
	# I think it's stopping the child emitters as well, but haven't confirmed.
	if not main_multi_spheres.emitting: #.finished()?
		queue_free()

func _physics_process(delta) -> void:
	position -= Mover.get_movement() * delta
