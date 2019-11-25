extends "res://src/components/Global/StateMachine.gd"


func _ready():
	add_state("idle")
	add_state("run")
	add_state("jump")
	add_state("fall")
	add_state("climb")
	add_state("hang")
	call_deferred("set_state", states.idle)

func _input(event):
	if [states.idle, states.run].has(state):
	#JUMP
		if parent.is_climbing == false:
			if event.is_action_pressed("jump"):
				parent.movement.y = parent.jump_height
				parent.is_jumping = true

func _state_logic(delta):
	parent.check_living_status()
	parent.handle_move_input()
	parent.apply_gravity(delta)
	parent.apply_movement()

func _get_transition(delta):
	match state:
		states.idle:
			if !parent.is_on_floor():
				if parent.movement.y < 0:
					return states.jump
				elif parent.movement.y > 0:
					return states.fall
			elif parent.movement.x != 0:
				return states.run
			if parent.is_on_floor() and parent.is_climbing == true:
				return states.climb
		states.run:
			if !parent.is_on_floor():
				if parent.movement.y < 0:
					return states.jump
				elif parent.movement.y > 0:
					return states.fall
			elif parent.movement.x == 0:
				return states.idle
		states.jump:
			if parent.is_on_floor():
				return states.idle
			elif parent.movement.y >= 0 and parent.is_climbing == false:
				return states.fall
			elif parent.movement.y != 0 and parent.is_climbing == true:
				return states.climb
		states.fall:
			if parent.is_on_floor():
				return states.idle
			elif parent.movement.y < 0 and parent.is_climbing == false:
				return states.jump
			elif parent.movement.y != 0 and parent.is_climbing == true:
				return states.climb
		states.climb:
			if parent.is_on_floor() and parent.is_climbing == false:
				return states.idle
			elif parent.movement.y < 0 and parent.is_climbing == false:
				return states.jump
			elif parent.movement.y > 0 and parent.is_climbing == false:
				return states.fall
			elif parent.movement.y == 0 and parent.is_climbing == true:
				return states.hang
		states.hang:
			if parent.is_on_floor() and parent.is_climbing == false:
				return states.idle
			if parent.movement.y != 0 and parent.is_climbing == true:
				return states.climb
			elif parent.movement.y != 0 and parent.is_climbing == false:
				return states.fall



func _enter_state(new_state, old_state):
	match new_state:
		states.idle:
			parent.anim_player.play("idle")
		states.run:
			parent.anim_player.play("run")
		states.jump:
			parent.anim_player.play("jump")
		states.fall:
			parent.anim_player.play("fall")
		states.climb:
			parent.anim_player.play("climb")
		states.hang:
			parent.anim_player.stop()
	pass

func _exit_state(old_state, new_state):
	pass