extends Node2D


func _on_back_button_up():
	get_tree().change_scene_to_file("res://main_menu.tscn")
	
func _process(delta):
	if Global.welcome_a == true:
		$Welcome.hide()
	
	if Global.escape_a == true:
		$Escape.hide()
	
	if Global.one_shot == true:
		$"One shot".hide()
	
	if Global.full_star_a == true:
		$"Full Star".hide()
	
	if Global.good_end == true:
		$"Good end".hide()
	
	if Global.defeat_boss == true:
		$"Defeat boss".hide()
	
	if Global.bad_end == true:
		$"bad end".hide()
	
	if Global.noob == true:
		$Noob.hide()
	
	if Global.full_heart == true:
		$"Full heart".hide()
