extends Area2D
@onready var nova: AnimatedSprite2D = $AnimatedSprite2D
@onready var nova_up_timer: Timer = $NovaUpTimer
@onready var nova_down_timer: Timer = $NovaDownTimer


func _on_nova_up_timer_timeout() -> void:
	nova_up_timer.stop()
	nova_down_timer.start()
	nova.visible = false
	monitoring = false
	
func _on_nova_down_timer_timeout() -> void:
	nova_down_timer.stop()
	nova_up_timer.start()
	nova.visible = true
	monitoring = true

func _ready():
	nova_down_timer.start()


func _on_body_entered(body: Node2D) -> void:
	if ("take_damage" in body):
		body.stunned()
		print("stunned")
