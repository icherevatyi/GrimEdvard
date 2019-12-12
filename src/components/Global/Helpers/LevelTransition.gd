extends Node


func _load_lvl(color_from, color_faded, next_lvl):
	Backdrop._fade_in(null, null, 0.6)
	assert(get_tree().change_scene(next_lvl) == OK)
	Backdrop._fade_out(null, 0.6)
	