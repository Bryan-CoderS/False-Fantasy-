extends Control

signal textbox_closed

@export var slime: Resource = null

var current_player_health = 0
var current_slime_hunger = 0
var is_defending = false
var a_c = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$SlimeContainer/GreenFire.hide()
	$SlimeContainer/RedFire.hide()
	$SlimeContainer/Boss.play("enter")
	set_hunger($SlimeContainer/ProgressBar, slime.hunger, slime.hunger)
	set_health($PlayerPanel/PlayerData/ProgressBar, StateH.current_health, StateH.max_health)
	
	current_player_health = StateH.current_health
	current_slime_hunger = slime.hunger
	
	$Textbox.hide()
	$ActionsPanel.hide()
	
	display_text("An angry %s appears!" % slime.name)
	await textbox_closed
	display_text("90/30")
	await textbox_closed
	display_text("A: 3 B: 1/3")
	await textbox_closed
	display_text("Choose one!")
	await textbox_closed
	$ActionsPanel.show()
	a_c = true
	
	
func _process(delta):
	if current_player_health == 0:
		display_text("You're killed by angry boss")
		await textbox_closed
		
		$AnimationPlayer.play("shake")
		await $AnimationPlayer
		
		await get_tree().create_timer(1.0).timeout	
		get_tree().change_scene_to_file("res://black.tscn")
		
	
func set_health(progress_bar, health, max_health):
	progress_bar.value = health
	progress_bar.max_value = max_health
	progress_bar.get_node("Label").text = "Hp: %d/%d" % [health, max_health]
	
func set_hunger(progress_bar, health, max_health):
	progress_bar.value = health
	progress_bar.max_value = max_health
	progress_bar.get_node("Label").text = "Hunger: %d/%d" % [health, max_health]
	
func _input(event):
	if (Input.is_action_just_pressed("ui_accept") or Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)) and $Textbox.visible:
		$Textbox.hide()
		emit_signal("textbox_closed")
		

func display_text(text):
	$ActionsPanel.hide()
	$Textbox.show()
	$Textbox/Label.text = text
	
	
	
func question1():
	display_text("x = y")
	await textbox_closed
	display_text("x + y = 30")
	await textbox_closed
	display_text("What is x?")
	await textbox_closed
	display_text("A: 20 B: 15")
	await textbox_closed
	$ActionsPanel.show()
	a_c = false	
		
func question2():
	display_text("7 * 8 = ?")
	await textbox_closed
	display_text("A: 56 B: 65")
	await textbox_closed
	$ActionsPanel.show()	
	a_c = true					
	
func question3():
	display_text("3 * 7 = ?")
	await textbox_closed
	display_text("A: 12 B: 21")
	await textbox_closed
	$ActionsPanel.show()
	a_c = false
	
func question4():
	display_text("1 + 1 * 2/1 = ?")
	await textbox_closed
	display_text("A: 3 B: 1")
	await textbox_closed
	$ActionsPanel.show()
	a_c = true
	
func question5():
	display_text("12 * 12 = ?")
	await textbox_closed
	display_text("A: 134 B: 144")
	await textbox_closed
	$ActionsPanel.show()
	a_c = false
	
func question6():
	display_text("2x + y = 60")
	await textbox_closed
	display_text("x + y = 45")
	await textbox_closed
	display_text("What is y?")
	await textbox_closed
	display_text("A: 30 B: 15")
	await textbox_closed
	$ActionsPanel.show()
	a_c = true
	
func question7():
	display_text("21 / 3 = ?")
	await textbox_closed
	display_text("A: 9 B: 7")
	await textbox_closed
	$ActionsPanel.show()
	a_c = false
	
func question8():
	display_text("4 + 5 * 2 = ?")
	await textbox_closed
	display_text("A: 14 B: 18")
	await textbox_closed
	$ActionsPanel.show()
	a_c = true
	
func question9():
	display_text("10 - 4 / 2 = ?")
	await textbox_closed
	display_text("A: 3 B: 8")
	await textbox_closed
	$ActionsPanel.show()
	a_c = false
	
func question10():
	display_text("(3 + 4) * 2 = ?")
	await textbox_closed
	display_text("A: 14 B: 11")
	await textbox_closed
	$ActionsPanel.show()
	a_c = true
	
func question11():
	display_text("80 * 20 = ?")
	await textbox_closed
	display_text("A: 1600 B: 160")
	await textbox_closed
	$ActionsPanel.show()
	a_c = true		
	
func slime_turn():
	var numbers = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
	var sucess = numbers[randi() % numbers.size()]
	if is_defending:
		is_defending = false
		display_text("Correct!!!")
		await textbox_closed
		$AnimationPlayer.play("mini_shake")
		await $AnimationPlayer
		display_text("You defended successfully")
		await textbox_closed
		if sucess == 0:
			question1()
		elif sucess == 1:
			question2()
		elif sucess == 2:
			question3()
		elif sucess == 3:
			question4()
		elif sucess == 4:
			question5()
		elif sucess == 5:
			question6()
		elif sucess == 6:
			question7()
		elif sucess == 7:
			question8()
		elif sucess == 8:
			question9()
		elif sucess == 9:
			question10()
		elif sucess == 10:
			pass
		else:
			pass
		
	else:
		display_text("Wrong!!! You dumb!")
		await textbox_closed
		current_player_health = max(0, current_player_health - slime.damage)
		set_health($PlayerPanel/PlayerData/ProgressBar, current_player_health, StateH.max_health)
		$SlimeContainer/Boss.play("attack")
		$AnimationPlayer.play("shake")
		$SlimeContainer/GreenFire.show()
		$SlimeContainer/RedFire.show()
		$AnimationPlayer.play("slime_attack")
		$SlimeContainer/GreenFire.show()
		$SlimeContainer/RedFire.show()
		if sucess == 0:
			question1()
		elif sucess == 1:
			question2()
		elif sucess == 2:
			question3()
		elif sucess == 3:
			question4()
		elif sucess == 4:
			question5()
		elif sucess == 5:
			question6()
		elif sucess == 6:
			question7()
		elif sucess == 7:
			question8()
		elif sucess == 8:
			question9()
		elif sucess == 9:
			question10()
		elif sucess == 10:
			pass
		else:
			pass
		
	$ActionsPanel.show()
	




func _on_a_pressed():
	if a_c == true:
		is_defending = true
		
		display_text("You: The answer is A!")
		await textbox_closed
	
		$SlimeContainer/Boss.play("get_attack")
			
		current_slime_hunger = max(0, current_slime_hunger - StateH.damage)
		set_hunger($SlimeContainer/ProgressBar, current_slime_hunger, slime.hunger)
		await get_tree().create_timer(1.0).timeout	
	
	if current_slime_hunger == 0:
		if Global.defeat_boss == false:
			Global.defeat_boss = true
			$Trophy.show()
			$ColorRect.show()
			$AudioStreamPlayer2D2.play()
			await get_tree().create_timer(1.5).timeout
			$Trophy.hide()
			$ColorRect.hide()
		display_text("%s is sastisfy" % slime.name)
		await textbox_closed
		
		$AnimationPlayer.play("slime_die")
		await  $AnimationPlayer
		
		await get_tree().create_timer(1.0).timeout	
		get_tree().change_scene_to_file("res://black_scene.tscn")
	
	slime_turn()


func _on_b_pressed():
	if a_c == false:
		is_defending = true
		
		display_text("You: The answer is B!")
		await textbox_closed
	
		$SlimeContainer/Boss.play("get_attack")
			
		current_slime_hunger = max(0, current_slime_hunger - StateH.damage)
		set_hunger($SlimeContainer/ProgressBar, current_slime_hunger, slime.hunger)
		await get_tree().create_timer(1.0).timeout
		
	if current_slime_hunger == 0:
		if Global.defeat_boss == false:
			Global.defeat_boss = true
			$Trophy.show()
			$ColorRect.show()
			$AudioStreamPlayer2D2.play()
			await get_tree().create_timer(1.5).timeout
			$Trophy.hide()
			$ColorRect.hide()
			
		display_text("%s is sastisfy" % slime.name)
		await textbox_closed
		
		$AnimationPlayer.play("slime_die")
		await  $AnimationPlayer
		
		await get_tree().create_timer(1.0).timeout	
		get_tree().change_scene_to_file("res://black_scene.tscn")
		
	slime_turn()


func _on_idk_pressed():
	display_text("I don't know!")
	await textbox_closed
	
	slime_turn()
	
