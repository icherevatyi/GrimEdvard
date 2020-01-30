extends Node

class Enemy:
	var hp_min
	var hp_max
	
	var damage_min
	var damage_max
	var damage_value

	var attack_type  # MELEE, RANGED, MAGIC, BOSS values are available for different enemies


	func move():
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
