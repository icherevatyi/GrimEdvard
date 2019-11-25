extends Node2D

onready var notification = $Notification


func _on_Trigger_body_entered(body):
	if body.name == "Player":
		notification.global_position.y = body.get_global_position().y - 25
		
		notification.visible = true
		


func _on_Trigger_body_exited(body):
	if body.name == "Player":
		notification.visible = false
