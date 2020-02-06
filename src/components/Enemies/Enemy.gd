extends KinematicBody2D


onready var movement_change_timer = $Timers/MoveChangeTimer
onready var floor_checker = $FloorChecker
onready var aggro_radius : Area2D = $Detectors/AggroRadius

var state_machine : AnimationNodeStateMachinePlayback

# health vars
var hp_min
var hp_max

# movement vars
var movement_dir
var direction = {"left": -1, "right": 1, "stay": 0}
var initial_speed = 50
var chasing_speed = 80
var speed
var gravity = 20
var velocity = Vector2(0, 0)

# damage and combat vars
var damage_min = 4
var damage_max = 20
var damage_value
var attack_type  # MELEE, RANGED, MAGIC, BOSS values are available for different enemies
var is_chasing : bool = false
var is_attacking : bool = false


func _ready():
	speed = initial_speed

	choose_movement_dir()
	randomize_movechange_timer()
	movement_change_timer.start()


func _physics_process(delta):
	apply_gravity()
	move()
	chase()
	
	calculate_damage(damage_min, damage_max)
	
	velocity = move_and_slide(velocity, Vector2(0, -1))
	check_obstickes()


func randomize_movechange_timer():
	var rand_number = randi() % 3 + 1
	randomize()

	movement_change_timer.set_wait_time(rand_number)


func _on_MoveChangeTimer_timeout():
	if is_chasing == false and is_attacking == false:
		randomize_movechange_timer()
		choose_movement_dir()


func choose_movement_dir():
	var rand_number = randi() % 3 + 1
	randomize()
	
	var prev_dir = 1
	match rand_number:
		1:
			movement_dir = direction.stay
		2:
			movement_dir = direction.left
		3:
			movement_dir = direction.right
	change_facing()


func change_facing():
	if movement_dir != 0:
		match movement_dir:
			1:
				floor_checker.position.x = 15
			-1:
				floor_checker.position.x = -15
		for child in get_children():
			if child.is_in_group("turnable"):
				child.scale.x = movement_dir


func apply_gravity():
	velocity.y += gravity 
	velocity.y = min(velocity.y, 1000)


func move():
	velocity.x = speed * movement_dir
	if is_chasing == true and is_attacking == false:
		speed = chasing_speed
	elif is_chasing == false and is_attacking == true:
		speed = 0
	else:
		speed = initial_speed


func check_obstickes():
	if floor_checker.is_colliding() == false:
		movement_dir *= -1
		change_facing()
	if is_on_wall() and is_chasing == false and is_attacking == false:
		movement_dir *= -1
		change_facing()


func _on_AggroRadius_entered(body):
	if body.name == "Player":
		is_chasing = true


func _on_AggroRadius_exited(body):
	if body.name == "Player":
		is_chasing = false


func chase():
	if is_chasing == true:
		for body in aggro_radius.get_overlapping_bodies():
			if body.name == "Player":
				match is_attacking:
					true:
						return
					false:
						var player_pos = body.get_global_position().x
						var enemy_pos = get_global_position().x
		
						var result : int = enemy_pos - player_pos
						if result < 0:
							movement_dir = 1
						if result > 0:
							movement_dir = -1
						change_facing()


func _on_AttackRange_entered(body):
	if body.name == "Player":
		is_attacking = true
		is_chasing = false

func _on_AttackRange_exited(body):
	if body.name == "Player":
		is_attacking = false
		is_chasing = true


func calculate_damage(damage_min, damage_max):
	match is_attacking:
		true:
			damage_value = randi() % damage_max + damage_min
			randomize()
			return damage_value
		false:
			return

func attack():
	if is_attacking == true:
		print(damage_value)


func _on_damage_taken(received_damage):
	pass


func check_if_alive():
	pass


func die():
	pass
	
