extends CanvasLayer

onready var colorRect = $ColorRect
onready var tween = $Tween

var starting_color
var ending_color
var color_transparent = Color(0, 0, 0, 0)
var color_black = Color(0, 0, 0, 1)
var color_black_transparent = Color(0, 0, 0, 0.6)

func _fade_in(color_from, color_faded, delay):
	check_color(color_from, color_faded)
	tween.interpolate_property(colorRect, "color", starting_color, ending_color, delay, Tween.TRANS_LINEAR, Tween.EASE_OUT_IN)
	tween.start()
	yield(tween, "tween_completed")


func _fade_out(color_faded, delay):
	check_color(null, color_faded)
	tween.interpolate_property(colorRect, "color", ending_color, color_transparent, delay, Tween.TRANS_LINEAR, Tween.EASE_OUT_IN)
	tween.start()
	yield(tween, "tween_completed")


func check_color(color_from, color_faded):
	if color_from != null:
		starting_color = color_from
	else:
		starting_color = color_transparent
	
	if color_faded != null:
		ending_color = color_faded
	else:
		ending_color = color_black
