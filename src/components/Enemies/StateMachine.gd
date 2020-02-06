extends Node2D

onready var parent : KinematicBody2D = get_parent()
onready var state_machine = parent.state_machine

enum STATES {
	idle,
	walk,
	attack,
	got_hit,
	death
}

func _ready():
	state_machine = parent.get_node("AnimationTree").get("parameters/playback")
	state_machine.start("idle")

func _process(delta):
	check_state()

func check_state():
	if parent.movement_dir == 0 and parent.velocity.x == 0 and parent.is_attacking == false:
		state_machine.travel("idle")
	if parent.movement_dir != 0 and parent.velocity.x != 0 and parent.is_attacking == false:
		state_machine.travel("walk")
	if parent.is_attacking == true:
		state_machine.travel("attack")
