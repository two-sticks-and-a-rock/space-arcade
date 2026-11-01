@tool
extends Node2D

var coords_cursor : Array[Array] = [[0,0], [20,40], [6,33], [6,50], [-6,50], [-6,33], [-20,40]]
var cursor_to_draw : PackedVector2Array

var end_of_line_pos : Vector2 = Vector2.ZERO

func float_array_to_Vector2Array(coords : Array) -> PackedVector2Array:
	var array : PackedVector2Array = []
	for coord in coords:
		array.append(Vector2(coord[0], coord[1]))
	return array

func _ready():
	cursor_to_draw = float_array_to_Vector2Array(coords_cursor)

func _draw():
	draw_polygon(cursor_to_draw, [ Color.WHITE ])

func _physics_process(_delta):
	position = end_of_line_pos
