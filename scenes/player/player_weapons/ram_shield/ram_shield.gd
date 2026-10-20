extends PlayerWeapon

@onready var ram_cam : PlayerBullet = $RamCap

func _reinstantiate_weapon():
	up_timer.start()

func _ready():
	super()

func _on_down_timer_timeout():
	up_timer.start()
	down_timer.stop()

	ram_cam.visible = true
	ram_cam.process_mode = Node.PROCESS_MODE_INHERIT

func _on_up_timer_timeout():
	down_timer.start()
	up_timer.stop()

	ram_cam.visible = false
	ram_cam.process_mode = Node.PROCESS_MODE_DISABLED