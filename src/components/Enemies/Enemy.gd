extends KinematicBody2D


# timers
onready var movement_change_timer = $Timers/MoveChangeTimer

#rayCasts
onready var floor_checker = $FloorChecker


var state_machine : AnimationNodeStateMachinePlayback

# health vars
var hp_min
var hp_max

# movement vars
var movement_dir
var direction = {"left": -1, "right": 1, "stay": 0}
var speed = 50
var gravity = 20
var velocity = Vector2(0, 0)

# damage and combat vars
var damage_min
var damage_max
var damage_value
var attack_type  # MELEE, RANGED, MAGIC, BOSS values are available for different enemies



func _ready():
	state_machine = $AnimationTree.get("parameters/playback")
	state_machine.start("idle")
	
	choose_movement_dir()
	randomize_movechange_timer()
	movement_change_timer.start()


func _physics_process(delta):
	apply_gravity()
	move()
	velocity = move_and_slide(velocity, Vector2(0, -1))
	check_obstickes()


func randomize_movechange_timer():
	var rand_number = randi() % 3 + 1
	randomize()

	movement_change_timer.set_wait_time(rand_number)


func _on_MoveChangeTimer_timeout():
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
	if movement_dir == 0 and velocity.x == 0:
		state_machine.travel("idle")
	else:
		state_machine.travel("walk")


func check_obstickes():
	if is_on_wall() or floor_checker.is_colliding() == false:
		movement_dir *= -1
		change_facing()

func chase():
	pass


func calculate_damage(damage_min, damage_max):
	pass


func attack(damage_value):
	pass


func _on_damage_taken(received_damage):
	pass


func check_if_alive():
	pass


func die():
	pass
	
