@tool
extends Node2D

var bright_red: Color =  Color.hex(0xFF2E4DFF)
var yellow: Color = Color.hex(0xFFD24AFF)
func _draw():
	var radius = 100
	var width = 30

	var center_width = floor(width / 2.0) as int
	var length = 150
	var overlap_center = 60

	var outline_width = width + 20
	var outline_center_width = floor(outline_width/2.0) as int
	var outline_overlap_center = overlap_center + 10
	var outline_length = length + 20

	draw_rect(Rect2(Vector2(-outline_center_width, radius-outline_overlap_center), Vector2(outline_width, outline_length)), bright_red, true) # up
	draw_rect(Rect2(Vector2(-outline_center_width, -radius+outline_overlap_center), Vector2(outline_width, -outline_length)), bright_red, true) # down
	draw_rect(Rect2(Vector2(-radius+outline_overlap_center, -outline_center_width), Vector2(-outline_length, outline_width)), bright_red, true) # right
	draw_rect(Rect2(Vector2(radius-outline_overlap_center, -outline_center_width), Vector2(outline_length, outline_width)), bright_red, true) # left

	draw_arc(Vector2(0,0), 100, 0, PI*2, radius, bright_red, outline_width)
	draw_arc(Vector2(0,0), 100, 0, PI*2, radius, yellow, width)

	draw_rect(Rect2(Vector2(-center_width, radius-overlap_center), Vector2(width, length)), yellow, true) # up
	draw_rect(Rect2(Vector2(-center_width, -radius+overlap_center), Vector2(width, -length)), yellow, true) # down
	draw_rect(Rect2(Vector2(-radius+overlap_center, -center_width), Vector2(-length, width)), yellow, true) # right
	draw_rect(Rect2(Vector2(radius-overlap_center, -center_width), Vector2(length, width)), yellow, true) # left