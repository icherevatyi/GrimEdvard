extends Node

class Enemy:
	var direction = {"left": -1, "right": 1}
	var hp_min
	var hp_max
	
	var speed
	var gravity
	
	var damage_min
	var damage_max
	var damage_value

	var attack_type  # MELEE, RANGED, MAGIC, BOSS values are available for different enemies
	
	func choose_movement_dir():
		var dir = randi() % 3 + 1
		randomize()
		
		match dir:
			1:
				stay_still()
			2:
				move(direction.left)
			3:
				move(direction.right)
	
	func stay_still():
		pass
	
	func move(direction):
		pass

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
