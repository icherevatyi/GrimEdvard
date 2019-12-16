extends Node2D

onready var next_lvl = Global.level_list.Brownville
signal change_water_state()

var limits = {
	"top": -370,
	"bottom": 208,
	"left": 0,
	"right": 3636
}



func _ready():
	Global.currentLvl = Global.level_list.Forest_start
	var playerInstance = Global.Player.instance()
	if Global.prevLvl == null:
		playerInstance.set_position($PlayerContainer/PlayerSpawn_StartLvl.get_global_position())
	else: 
		playerInstance.set_position($PlayerContainer/PlayerSpawn_EndLvl.get_global_position())
	
	$PlayerContainer.add_child(playerInstance)


func _on_To_next_body_entered(body):
	if body.name == "Player":
		LevelTransition._load_lvl(null, null, Global.level_list.Brownville)

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		print("grab?")

func _on_Water_trigger_body_entered(body):
	if body.name == "Player":
		emit_signal("change_water_state")


func _on_Water_trigger_body_exited(body):
	if body.name == "Player":
		emit_signal("change_water_state")
