extends Node2D

#general vars
onready var parent = get_parent()

# hp vars
var hp_min = 0
var hp_max = 100
var hp_current
export(bool) var damage_received = false

# stamina bars
var stam_min = 0
var stam_max = 100
var stam_current

#signals
signal player_died()
signal on_health_change(prev_amount, curr_amount)
signal initialize_HP(max_val, curr_val)
signal initialize_Stamina(max_val, curr_val)

func _ready():
	set_hp()
	set_stamina()
	

func set_hp():
	hp_current = hp_max

func set_stamina():
	stam_current = stam_max

func init_HUD_bars():
	emit_signal("initialize_HP", hp_max, hp_current)
	emit_signal("initialize_Stamina", stam_max, stam_current)

func _input(event):
	if event.is_action_pressed("take_damage"):
		take_damage(20)

func take_damage(damage):
	damage_received = true
	var new_hp_val = hp_current - damage
	emit_signal("on_health_change", hp_current, new_hp_val)
	hp_current = new_hp_val
	player_dead_check()
	

func player_dead_check():
	if hp_current <= hp_min:
		emit_signal("player_died")

func _on_outside_camera():
	take_damage(10)

func show_deathscreen():
	DeathScreen.show_deathscreen()