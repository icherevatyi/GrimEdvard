extends CanvasLayer

onready var Joy_area = $Buttons/Joystick_area
onready var Joy_btn = $Buttons/Joystick_area/Joystick_btn

var radius = Vector2(185, 185)
var boundary = 570
var return_accel = 20
var ongoing_drag = -1
var treshold_max = 210
var treshold_min = -210


func _ready():
	if OS.get_name() != "Android" and OS.get_name() != "BlackBerry 10" and OS.get_name() != "iOS":
		$Buttons/Joystick_area.hide()

func _process(delta):
	if ongoing_drag == -1:
		var pos_difference = (Vector2(0, 0) - radius) - Joy_btn.position
		Joy_btn.position += pos_difference * return_accel * delta


func get_button_pos():
	return Joy_btn.position + radius

func _input(event):
	if event is InputEventScreenDrag or (event is InputEventScreenTouch and event.is_pressed()):
		var event_dist_from_centre = (event.position - Joy_area.position).length()
		
		if event_dist_from_centre <= boundary * Joy_btn.global_scale.x or event.get_index() == ongoing_drag:
			Joy_btn.set_global_position(event.position - radius * Joy_btn.global_scale)
		
			if get_button_pos().length() > boundary:
				Joy_btn.set_position(get_button_pos().normalized() * boundary - radius)
			
			ongoing_drag = event.get_index()
			
	if event  is InputEventScreenTouch and !event.is_pressed() and event.get_index() == ongoing_drag:
		ongoing_drag = -1

func get_joystick_x():
	if get_button_pos().x > 0 and get_button_pos().x > treshold_max:
		return 1
	elif get_button_pos().x < 0 and get_button_pos().x < treshold_min: 
		return -1
	else:
		return 0

func get_joystick_y():
	if get_button_pos().y < 0 and get_button_pos().y < treshold_min:
		return -1
	else: 
		return 0