extends PlayerWeapon

@onready var player : StaticBody2D = get_parent() as StaticBody2D

@onready var ram_cap : PlayerBullet = $RamCap
@onready var power_up : TextureProgressBar = $RamCap/AnimatedSprite2D/TextureProgressBar
#@onready var shield_bubble : Sprite2D = $ShieldBubble
@onready var animationPlayer : AnimationPlayer = $AnimationPlayer
@export var time_warning : float = 2.0


func _reinstantiate_weapon():
	up_timer.start()

func _ready():
	super()
	power_up.value = down_timer.wait_time
	power_up.max_value = down_timer.wait_time
	player.immune_to_damage = true

func _on_down_timer_timeout():
	up_timer.start()
	down_timer.stop()
	Sfx.play("shield_up")

	ram_cap.sprite.self_modulate.a = 1
	player.immune_to_damage = true
	ram_cap.collider.disabled = false
	
	animationPlayer.play_backwards("fade_out")
	await animationPlayer.animation_finished

func _on_up_timer_timeout():
	down_timer.start()
	up_timer.stop()
	Sfx.play("shield_down")

	ram_cap.sprite.self_modulate.a = 0.5
	player.immune_to_damage = false
	power_up.max_value = down_timer.wait_time
	ram_cap.collider.disabled = true
	
	animationPlayer.play("fade_out")
	await animationPlayer.animation_finished

func _physics_process(_delta):
	#pass
	#power_up.value = down_timer.wait_time-down_timer.time_left
	if up_timer.is_stopped() == true: 
		#shield_bubble.self_modulate = Color(1.0, 0.277, 0.15, 1.0)

		#power_up.tint_progress = Color("694bff")
		#power_up.tint_under = Color("000000")
		#power_up.set_fill_mode(0) # FILL_LEFT_TO_RIGHT = 0 / FILL_RIGHT_TO_LEFT = 1
		power_up.value = down_timer.wait_time-down_timer.time_left
		
		
	if up_timer.is_stopped() != true: 
		#shield_bubble.self_modulate = Color(1.0, 0.149, 0.945, 1.0)
		
		#power_up.tint_progress = Color("00ef15")
		#power_up.tint_under = Color("005c08ff")
		#power_up.set_fill_mode(1)
		power_up.value = up_timer.time_left
		if up_timer.time_left <= time_warning: 
			animationPlayer.play("time_out_warning")
			await animationPlayer.animation_finished
