extends PlayerWeapon

@onready var player : StaticBody2D = get_parent() as StaticBody2D

@onready var ram_cap : PlayerBullet = $RamCap
@onready var power_up : TextureProgressBar = $RamCap/AnimatedSprite2D/TextureProgressBar

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

	ram_cap.sprite.self_modulate.a = 1
	player.immune_to_damage = true
	ram_cap.collider.disabled = false

func _on_up_timer_timeout():
	down_timer.start()
	up_timer.stop()

	ram_cap.sprite.self_modulate.a = 0.5
	player.immune_to_damage = false
	power_up.max_value = down_timer.wait_time
	ram_cap.collider.disabled = true

func _physics_process(_delta):
	power_up.value = down_timer.wait_time-down_timer.time_left
