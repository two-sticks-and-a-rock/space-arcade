extends Line2D

"""
    This object handles the "slingshot"/"pull-back-and-release" movement mechanic

    Mouse and keyboard
    - Player clicks on any point inside of the frame
    - Player holds the click and drags any direction
    - Based on the direction the player drags and the distance from the original
        point in the frame, once the player releases the click the player character 
        should move in the OPPOSITE direction 
    - TBD: how fast should the player character go
    - TBD: should we cap the velocity
    - TBD: how many times should the player ricochet (what is the velocity decay when colliding?)
    - TBD: should we hard cap the number of times the player ricochets?
    - TBD: Do we allow slow drift?
    - TBD: steering?
"""
@onready var player = get_parent().get_node("player")

var start_vector := Vector2.ZERO
var end_vector := Vector2.ZERO

func _input(_event: InputEvent) -> void:
    if Input.is_action_just_pressed("click"):
        # The moment the mouse click happens, save the start vector
        start_vector = get_global_mouse_position()
        end_vector = start_vector
    if Input.is_action_pressed("click"):
        # While the player holds the button, update the end_vector
        end_vector = get_global_mouse_position()
        add_point(start_vector, 0)
        add_point(end_vector, 1)
    if Input.is_action_just_released("click"):
        # When the player releases, set the direction of the ship
        player.direction = ((start_vector - end_vector)*2).normalized()

        
