extends Node2D

onready var next_lvl = Global.level_list.Brownville
signal change_water_state()

onready var playerInstance = Global.Player.instance()
onready var spawn_point = {
	"start_lvl": $PlayerContainer/PlayerSpawn_StartLvl.get_global_position(),
	"end_lvl": $PlayerContainer/PlayerSpawn_EndLvl.get_global_position()
}

var limits = {
	"top": -370,
	"bottom": 208,
	"left": 0,
	"right": 3636
}


func _ready():
	Global.currentLvl = Global.level_list.Forest_start	
	spawn_player(playerInstance, Global.prevLvl, spawn_point)	
	$PlayerContainer.add_child(playerInstance)

func spawn_player(player, prev_lvl, spawn_point):
	if prev_lvl == null:
		player.set_position(spawn_point.start_lvl)
	else: 
		player.set_position(spawn_point.end_lvl)

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
