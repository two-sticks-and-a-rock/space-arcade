extends Area2D

@onready var stun_timer : Timer = $StunTimer as Timer
var dmg = 15
var is_stunned = false

func _ready():
    stun_timer.wait_time = 2

func set_collision_radius(new_rad: float):
    (($CollisionShape2D as CollisionShape2D).shape as CircleShape2D).radius = new_rad

func _on_stun_timer_timeout():
    is_stunned = false

func _on_ram_entered(body: Node2D):
    if (is_stunned):
        print("not dealing damage")
        return

    if (body.name == "player" && "take_damage" in body):
        stun_timer.start()
        print("dealing damage")
        body.take_damage(dmg)
        is_stunned = true

        