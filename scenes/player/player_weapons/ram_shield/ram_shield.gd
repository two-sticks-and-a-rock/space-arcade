extends PlayerWeapon

@onready var ram_cap : PlayerBullet = $RamCap
@onready var power_up : TextureProgressBar = $RamCap/AnimatedSprite2D/TextureProgressBar

var up_timer_threshold : float = 1.0

func _reinstantiate_weapon():
	up_timer.start()

func _ready():
	super()
	power_up.value = down_timer.wait_time
	power_up.max_value = down_timer.wait_time

func _on_down_timer_timeout():
	up_timer.start()
	down_timer.stop()

	ram_cap.collider.disabled = false

func _on_up_timer_timeout():
	down_timer.start()
	up_timer.stop()

	power_up.max_value = down_timer.wait_time
	ram_cap.collider.disabled = true

func _physics_process(_delta):
	power_up.value = down_timer.wait_time-down_timer.time_left

	if (!up_timer.is_stopped() && up_timer.time_left < up_timer_threshold):
		power_up.set_visible(randi_range(0,1))