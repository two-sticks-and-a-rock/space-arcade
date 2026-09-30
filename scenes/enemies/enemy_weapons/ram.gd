extends Area2D

@onready var stun_timer : Timer = $StunTimer as Timer
var dmg = 15

func _ready():
    stun_timer.wait_time = 1

func set_collision_radius(new_rad: float):
    (($CollisionShape2D as CollisionShape2D).shape as CircleShape2D).radius = new_rad + 4

func _on_stun_timer_timeout():
    $CollisionShape2D.set_deferred("disabled", false)

func _on_ram_entered(body: Node2D):
    if (body.name == "player" && "take_damage" in body):
        $CollisionShape2D.set_deferred("disabled", true)
        stun_timer.start()
        body.take_damage(dmg)

        