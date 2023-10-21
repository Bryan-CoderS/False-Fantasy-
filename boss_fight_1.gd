extends Control

signal textbox_closed

@export var slime: Resource = null

var current_player_health = 0
var current_slime_hunger = 0
var is_defending = false
var question_1 = false
var question_2 = false
var question_3 = false
var question_4 = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$SlimeContainer/Boss.play("enter")
	set_hunger($SlimeContainer/ProgressBar, slime.hunger, slime.hunger)
	set_health($PlayerPanel/PlayerData/ProgressBar, StateH.current_health, StateH.max_health)
	
	current_player_health = StateH.current_health
	current_slime_hunger = slime.hunger
	
	$Textbox.hide()
	$ActionsPanel.hide()
	
	display_text("A angry %s appears!" % slime.name)
	await textbox_closed
	display_text("90/30")
	await textbox_closed
	display_text("A: 3 B: 1/3")
	await textbox_closed
	display_text("Choose one!")
	await textbox_closed
	$ActionsPanel.show()
	
	
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
	question_1 = true
	display_text("x = y")
	await textbox_closed
	display_text("x + y = 30")
	await textbox_closed
	display_text("What is x?")
	await textbox_closed
	display_text("A: 15 B: 20")
	await textbox_closed
	$ActionsPanel.show()		
		
func question2():
	question_2 = true
	display_text("7 * 8 = ?")
	await textbox_closed
	display_text("A: 56 B: 65")
	await textbox_closed
	$ActionsPanel.show()						
	
func question3():
	question_3 = true
	display_text("3 * 7")
	await textbox_closed
	display_text("A: 21 B: 12")
	await textbox_closed
	$ActionsPanel.show()		
	
func question4():
	question_4 = true
	display_text("1 + 1 * 2/1 = ?")
	await textbox_closed
	display_text("A: 3 B: 1")
	await textbox_closed
	$ActionsPanel.show()			
	
func slime_turn():
	if is_defending:
		is_defending = false
		display_text("Correct!!!")
		await textbox_closed
		$AnimationPlayer.play("mini_shake")
		await $AnimationPlayer
		display_text("You defended successfully")
		await textbox_closed
		if question_1 == false:
			question1()
		elif question_2 == false:
			question2()
		elif question_3 == false:
			question3()
		elif question_4 == false:
			question4()
		else:
			pass
		
	else:
		display_text("Wrong!!! You dumb!")
		await textbox_closed
		current_player_health = max(0, current_player_health - slime.damage)
		set_health($PlayerPanel/PlayerData/ProgressBar, current_player_health, StateH.max_health)
		$SlimeContainer/Boss.play("attack")
		$AnimationPlayer.play("shake")
		await $AnimationPlayer
		display_text("%s dealt %d damage!" % [slime.name, slime.damage])
		await textbox_closed
		display_text("More!!!")
		await textbox_closed
		display_text("1 + 2 * 3 = ?")
		await textbox_closed
		display_text("A: 7 B: 9")
		await textbox_closed
		
	$ActionsPanel.show()
	




func _on_a_pressed():
	is_defending = true
	
	display_text("You: The answer is A!")
	await textbox_closed
	
	$SlimeContainer/Boss.play("get_attack")
		
	current_slime_hunger = max(0, current_slime_hunger - StateH.damage)
	set_hunger($SlimeContainer/ProgressBar, current_slime_hunger, slime.hunger)
	await get_tree().create_timer(1.0).timeout	
	
	if current_slime_hunger == 0:
		display_text("%s is sastify" % slime.name)
		await textbox_closed
		
		$AnimationPlayer.play("slime_die")
		await  $AnimationPlayer
		
		await get_tree().create_timer(1.0).timeout	
		get_tree().change_scene_to_file("res://black_scene.tscn")
	
	slime_turn()


func _on_b_pressed():
	display_text("You: The answer is B!")
	await textbox_closed

	slime_turn()


func _on_idk_pressed():
	display_text("I don't know!")
	await textbox_closed
	
	slime_turn()
	
