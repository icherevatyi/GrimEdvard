extends CanvasLayer

var is_paused = false

onready var transition_color = $Control/Backdrop.color

func pause_toggle():
	$Control.visible = !$Control.visible
	get_tree().paused = !get_tree().paused

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		pause_toggle()

func _on_NewGame_pressed():
	pause_toggle()
	Global.prevLvl = null
	LevelTransition._load_lvl(Global.newGameLvl, transition_color)

func _on_Restart_pressed():
	pause_toggle()
	Global.prevLvl = null
	LevelTransition._load_lvl(Global.currentLvl, transition_color)

func _on_Quit_pressed():
	get_tree().quit()