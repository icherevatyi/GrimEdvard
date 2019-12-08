extends CanvasLayer

onready var tween = $Tween
onready var control = $Control

func show_deathscreen():
	get_tree().get_root().set_disable_input(true)
	Backdrop._fade_in(null, Backdrop.color_black_transparent, 0.6)
	tween.interpolate_property(control, "visible", false, true, 0.8, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	tween.start()
	yield(tween, "tween_completed")
	yield(get_tree().create_timer(1), "timeout")
	tween.interpolate_property(control, "visible", true, false, 0.2, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	tween.start()
	yield(tween, "tween_completed")
	Backdrop._fade_in(Backdrop.color_black_transparent, null, 0.2)
	yield(get_tree().create_timer(0.3), "timeout")
	assert(get_tree().change_scene(Global.currentLvl) == OK)
	yield(get_tree().create_timer(0.3), "timeout")
	Backdrop._fade_out(null, 0.6)
	get_tree().get_root().set_disable_input(false)
