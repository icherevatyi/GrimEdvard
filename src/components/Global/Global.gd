extends Node

onready var Player = preload("res://src/components/Player/Player.tscn")
onready var is_player_dead = false

onready var level_list = {
	"Forest_start": "res://src/components/Levels/Forest/Forest.tscn",
	"Brownville": "res://src/components/Levels/Brownville/Brownville.tscn"
}
onready var newGameLvl = Global.level_list.Forest_start
onready var currentLvl
onready var prevLvl