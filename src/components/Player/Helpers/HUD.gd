extends CanvasLayer

onready var player_screen = $Panels/PlayerScreen
onready var tween = $Tween
onready var hp_bar_over = $StatBars/HP_over
onready var hp_bar_under = $StatBars/HP_under
onready var stam_bar = $StatBars/Stamina

func _input(event):
	if event.is_action_pressed("ui_player_screen"):
		player_screen.visible = !player_screen.visible

func _on_health_change(prev_amount, curr_amount):
	update_HP_bar(prev_amount, curr_amount)

func update_HP_bar(prev_amount, curr_amount):
	hp_bar_over.value = curr_amount
	
	tween.interpolate_property(hp_bar_under, "value", prev_amount, curr_amount, 0.4, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()

func _on_initialize_HP(max_val, curr_val):
	hp_bar_over.max_value = max_val
	hp_bar_over.value = curr_val
	
	hp_bar_under.max_value = max_val
	hp_bar_under.value = curr_val


func _on_initialize_Stamina(max_val, curr_val):
	stam_bar.max_value = max_val
	stam_bar.value = curr_val
