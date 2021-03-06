extends KinematicBody2D

var is_jumping := false
var is_grounded
var is_dead := false
var is_attacking := false
var is_dodging := false
var is_climbing := false

var is_night_time := false

const UP = Vector2(0, -1)
const SLOPE_STOP = 64
var movement = Vector2(0,0)
var move_direction = 0
var vertical_direction = 0
var move_speed := 5 * 32
var gravity := 20
var jump_height := -370
onready var anim_player = $AnimationPlayer
onready var climb_collider = $ActionChecker
onready var currentLevel = get_node("/root/World")
onready var is_grounded_notifiers = $Grounded_notifiers

export(int) var attack_combo_counter = 0

signal grounded_updated(is_grounded)

func _ready():
	set_camera_limits()

func set_camera_limits():
	$Camera.limit_top = currentLevel.limits.top
	$Camera.limit_bottom = currentLevel.limits.bottom
	$Camera.limit_left = currentLevel.limits.left
	$Camera.limit_right = currentLevel.limits.right
	
func check_living_status():
	if position.y > $Camera.limit_bottom + 20:
		is_dead = true
		Global.is_player_dead = true

func check_if_grounded():
	for notifier in is_grounded_notifiers.get_children():
		if notifier.is_colliding():
			return true
		else: 
			return false

func apply_gravity(delta):
	if is_climbing == false:
		movement.y += gravity
		movement.y = min(movement.y, 1000)
		set_collision_mask_bit(1, true)

func apply_movement():
	movement = move_and_slide(movement, UP, true)
	is_grounded = check_if_grounded()
	var was_grounded = is_grounded
	if was_grounded == null || is_grounded != was_grounded:
		emit_signal("grounded_updated", is_grounded)

	if climb_collider.is_colliding():
		if climb_collider.get_collider().get_parent().is_in_group("climable"):
			if Input.is_action_just_pressed("ui_accept"):
				position.x = climb_collider.get_collider().get_global_position().x
				is_climbing = !is_climbing
				movement.y = 0
	else: 
		is_climbing = false

func _input(event):
	if event.is_action_pressed("ui_attack"):
		if attack_combo_counter == 0:
			anim_player.play("attack_1")
			attack_combo_counter += 1
		elif attack_combo_counter == 1:
			anim_player.play("attack_2")
			attack_combo_counter += 1
		elif attack_combo_counter == 2:
			anim_player.play("attack_3")
			attack_combo_counter = 0
		
func handle_move_input():
	if is_climbing == false:
		move_direction = - int(Input.is_action_pressed("ui_left")) + int(Input.is_action_pressed("ui_right"))
		movement.x = lerp(movement.x, move_speed * move_direction, 0.1)
		if move_direction != 0:
			for child in get_children():
				if child.is_in_group("turnable"):
					child.scale.x = move_direction
		else:
			movement.x = lerp(movement.x, 0, 1)

	#CLIMBING!:
	if is_climbing == true:
		set_collision_mask_bit(1, false)
		movement.y = 0
		if  vertical_direction == 0:
			movement.y = 0
		vertical_direction = - int(Input.is_action_pressed("ui_up")) + int(Input.is_action_pressed("ui_down"))
		movement.y =  move_speed * vertical_direction