extends PlayerWeapon
"""
STELLAR SHOCKWAVE
"""

@onready var player : StaticBody2D = get_parent() as StaticBody2D

@onready var ram_cap : PlayerBullet = $RamCap
@onready var power_up : TextureProgressBar = $RamCap/AnimatedSprite2D/TextureProgressBar
@onready var animationPlayer : AnimationPlayer = $AnimationPlayer
@export var time_warning : float = 2.0


func _reinstantiate_weapon():
	down_timer.start()
	ram_cap.sprite.self_modulate.a = 0.5
	player.immune_to_damage = false
	power_up.max_value = down_timer.wait_time
	ram_cap.collider.disabled = true
	
	animationPlayer.play("fade_out")

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
	if up_timer.is_stopped() == true: 
		power_up.value = down_timer.wait_time-down_timer.time_left
		
		
	if up_timer.is_stopped() != true: 
		power_up.value = up_timer.time_left
		if up_timer.time_left <= time_warning: 
			animationPlayer.play("time_out_warning")
			await animationPlayer.animation_finished
