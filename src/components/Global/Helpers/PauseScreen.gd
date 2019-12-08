extends CanvasLayer


var menu_backdrop = Color(0, 0, 0, 0.4)


func pause_toggle():
	if get_tree().paused == false:
		Backdrop._fade_in(null, menu_backdrop, 0.1)
		$Control.visible = !$Control.visible
	else: 
		$Control.visible = !$Control.visible
		Backdrop._fade_out(menu_backdrop, 0.1)
	get_tree().paused = !get_tree().paused


func _input(event):
	if event.is_action_pressed("ui_cancel"):
		pause_toggle()

func _on_NewGame_pressed():
	pause_toggle()
	DeathScreen.set_process(false)
	Global.prevLvl = null
	LevelTransition._load_lvl(null, menu_backdrop, Global.newGameLvl)

func _on_Restart_pressed():
	pause_toggle()
	DeathScreen.set_process(false)
	Global.prevLvl = null
	LevelTransition._load_lvl(null, menu_backdrop, Global.currentLvl)

func _on_Quit_pressed():
	get_tree().quit()