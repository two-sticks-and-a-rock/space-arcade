extends Node2D

@onready var drag_line : Line2D = $DragLine
@onready var sling_line : Line2D = $SlingLine
@onready var cursor : Node2D = $Cursor

var drag_line_start_point : Vector2 = Vector2.ZERO
var drag_line_end_point : Vector2 = Vector2.ZERO

var sling_line_start_point : Vector2 = Vector2(-50, -50)
var sling_line_end_point : Vector2 = Vector2(-50, -50)

var max_line_length : int = 500
var grow_rate : float = 300
var should_reset : bool = false

var should_show_tutorial : bool = true
var min_click_length_to_remove_tutorial : float = 1.0
var click_length : float = 0.0

var max_animations_to_show : int = 5
var num_animations_shown : int = 0
func _ready():
    drag_line.add_point(drag_line_start_point)

func handle_removing_tutorial(delta: float) -> void:
    if (num_animations_shown >= max_animations_to_show):
        should_show_tutorial = false
        return
        
    if Input.is_action_pressed("click"):
        click_length += delta
    if Input.is_action_just_released("click"):
        if (click_length > min_click_length_to_remove_tutorial):
            should_show_tutorial = false
        click_length = 0
        return
    
    if (abs(Mover.get_movement().length()) >= Mover.slingshot_length_clamp):
        should_show_tutorial = false
    
func _physics_process(delta: float):
    handle_removing_tutorial(delta)

    if (!should_show_tutorial):
        queue_free()
        return

    drag_line.clear_points()
    sling_line.clear_points()

    if (should_reset):
        drag_line_end_point = Vector2.ZERO
        sling_line_end_point = Vector2(50, -50)
        should_reset = false
        num_animations_shown += 1
        return
        
    drag_line_end_point += Vector2(-delta * grow_rate, delta * grow_rate)
    sling_line_end_point += Vector2(delta * grow_rate, -delta * grow_rate)
    if abs((drag_line_start_point-drag_line_end_point).length()) >= max_line_length:
        should_reset = true

    drag_line.add_point(drag_line_start_point)
    drag_line.add_point(drag_line_end_point)
    sling_line.add_point(sling_line_start_point)
    sling_line.add_point(sling_line_end_point)
    cursor.end_of_line_pos = drag_line_end_point
