extends Line2D

@onready var player = get_parent() as StaticBody2D

var start_vector := Vector2.ZERO
var end_vector := Vector2.ZERO

@onready var sprite: Sprite2D = $"../Sprite2D"

signal engine_burn

# for WASD controls
#var rotate_wasd_direction : int = 0
#@export var rotate_wasd_speed : float = 8.0
#@export var sling_charge_rate : float = 8.0
#var sling_is_charging : int = 0
#var sling_charge : float = 0
#var use_wasd : bool = false

func _ready():
	modulate = self_modulate * 4.0

func handle_speed(slingshot_vector: Vector2):
		Mover.direction = slingshot_vector.normalized()
		Mover.speed = slingshot_vector.length()

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("click"):
		clear_points()
		start_vector = get_global_mouse_position()
		end_vector = start_vector
	if Input.is_action_pressed("click"):
		end_vector = get_global_mouse_position()
		clear_points()

		var visible_direction = (start_vector - end_vector).normalized()*80
		var visible_start_vector = to_local(player.global_position + visible_direction)  
		var visible_end_vector = to_local(player.global_position + (start_vector - end_vector).limit_length(Mover.slingshot_length_clamp) + visible_direction) 
		add_point(visible_start_vector, 0)
		add_point(visible_end_vector, 1)

	if Input.is_action_just_released("click"):
		emit_signal("engine_burn")
		clear_points()
		var slingshot_vector = (start_vector - end_vector).limit_length(Mover.slingshot_length_clamp)
		handle_speed(slingshot_vector)
		Sfx.thrust_start()	
		
	
	# code for WASD controls
	#if _event.is_action_pressed("move_left"): 
		#rotate_wasd_direction = -1
		#
	#if _event.is_action_pressed("move_right"): 
		#rotate_wasd_direction = 1
	#if _event.is_action_released("move_left") or _event.is_action_released("move_right"):
		#rotate_wasd_direction = 0
	#
	#if _event.is_action_pressed("move_forward"): 
		#sling_is_charging = 1
	#if _event.is_action_pressed("move_back"): 
		#sling_is_charging = -1
	#if _event.is_action_released("move_forward") or _event.is_action_released("move_back"): 
		#sling_is_charging = 0
		#
	#if _event.is_action_pressed("sling_release"): 
		#var tempVector2 = Vector2(1, 0).rotated(sprite.rotation)
		#Mover.direction = tempVector2 
		#Mover.speed = sling_charge 
		#Sfx.thrust_start()
		##sling_charge = 0
		#sling_is_charging = 0
		#
	#if _event is InputEventKey: 
		#use_wasd = true
	#if _event is InputEventMouse: 
		#use_wasd = false
		
func _physics_process(_delta: float) -> void:
	#if use_wasd == false: 
		#sprite.look_at(-1*get_global_mouse_position())
		pass
		
	#if use_wasd == true: 
		#sprite.rotate(rotate_wasd_direction * rotate_wasd_speed * _delta)
		#sling_charge += sling_is_charging * sling_charge_rate
		#sling_charge = clamp(sling_charge, 0, 500)
		
