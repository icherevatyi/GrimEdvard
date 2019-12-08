extends CanvasLayer

onready var animation_player = $AnimationPlayer
onready var colorRect = $ColorRect
onready var tween = $Tween

var starting_color
var color_transparent = Color(0, 0, 0, 0)
var color_black = Color(0, 0, 0, 1)
var color_death = Color(89,7, 21, 0.6)

var delay = 0.6

func _load_lvl(next_lvl, color):
	check_color(color)
	tween.interpolate_property(colorRect, "color", starting_color, color_black, delay, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start()
	yield(tween, "tween_completed")
	assert(get_tree().change_scene(next_lvl) == OK)
	tween.interpolate_property(colorRect, "color", color_black, color_transparent, delay, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	tween.start()

func _death_screen():
	tween.interpolate_property(colorRect, "color", starting_color, color_death, 1, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start()
	yield(tween, "tween_completed")
	assert(get_tree().change_scene(Global.currentLvl) == OK)
	tween.interpolate_property(colorRect, "color", color_death, color_transparent, delay, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	tween.start()

func check_color(color):
	if color != null:
		starting_color = color
	else:
		starting_color = color_transparent
	