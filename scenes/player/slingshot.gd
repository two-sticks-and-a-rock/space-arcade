extends Line2D

@onready var player = get_parent() as RigidBody2D

var start_vector := Vector2.ZERO
var end_vector := Vector2.ZERO


func _input(_event: InputEvent) -> void:
    if Input.is_action_just_pressed("click"):
        clear_points()
        # The moment the mouse click happens, save the start vector
        start_vector = get_global_mouse_position()
        end_vector = start_vector
    if Input.is_action_pressed("click"):
        # While the player holds the button, update the end_vector
        end_vector = get_global_mouse_position()
        clear_points()

        var visible_start_vector = to_local(player.global_position)
        var visible_end_vector = to_local(player.global_position + (start_vector - end_vector))
        add_point(visible_start_vector, 0)
        add_point(visible_end_vector, 1)
    if Input.is_action_just_released("click"):
        # When the player releases, set the direction of the ship
        clear_points()
        player.direction = start_vector - end_vector
