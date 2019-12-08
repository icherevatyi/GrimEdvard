extends Node2D

signal modulate_nighttime

var limits = {
	"top": -370,
	"bottom": 288,
	"left": 0,
	"right": 2880
}

func _ready():
	Global.currentLvl = Global.level_list.Brownville
	Global.prevLvl = Global.currentLvl
	var playerInstance = Global.Player.instance()
	playerInstance.set_position($PlayerContainer/PlayerSpawn.get_global_position())
	$PlayerContainer.add_child(playerInstance)

func _on_To_Forest_body_entered(body):
	if body.name == "Player":
		LevelTransition._load_lvl(null, null, Global.level_list.Forest_start)