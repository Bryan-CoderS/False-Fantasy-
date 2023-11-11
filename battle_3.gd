extends Control

signal textbox_closed

@export var slime: Resource = null

var current_player_health = 0
var current_slime_hunger = 0
var is_defending = false
var is_running = false
var is_dying = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$CombatBar.hide()
	$CombatSlimebar.hide()
	set_hunger($SlimeContainer/ProgressBar, slime.hunger, slime.hunger)
	set_health($PlayerPanel/PlayerData/ProgressBar, StateH.current_health, StateH.max_health)
	$SlimeContainer/Slime.texture = slime.texture
	
	current_player_health = StateH.current_health
	current_slime_hunger = slime.hunger
	
	$Textbox.hide()
	$ActionsPanel.hide()
	
	display_text("Press space to start" )
	await textbox_closed
	display_text("A hungry %s appears!" % slime.name)
	await textbox_closed
	$ActionsPanel.show()
	
func _process(delta):
	if current_player_health <= 0:
		is_dying = true
		display_text("You're killed by hungry slime")
		await textbox_closed
		
		$AnimationPlayer.play("shake")
		await $AnimationPlayer
		
	if is_dying:
		is_dying = false
		await get_tree().create_timer(1.0).timeout
		Global.hp = Global.hp - 1
		print (Global.hp)
		get_tree().change_scene_to_file("res://scene_3_1.tscn")
		
	if Global.stop == true:
		Global.stop = false 
		_on_timer_timeout()
		
	
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

func slime_turn():
	if current_slime_hunger == 0:
		display_text("%s is full" % slime.name)
		await textbox_closed
		display_text("%s leave with satisfaction" % slime.name)
		await textbox_closed

		$SlimeEat.hide()
		$AnimationPlayer.play("slime_die")

		await get_tree().create_timer(1.0).timeout	
		get_tree().change_scene_to_file("res://scene_3_1.tscn")
		
	$CombatBar.hide()
	$CombatSlimebar.hide()
	if is_defending:
		is_defending = false
		$AnimationPlayer.play("mini_shake")
		var numbers = [0, 1, 2]
		var sucess = numbers[randi() % numbers.size()]
		if sucess == 1:
			display_text("You defended successfully")
			await textbox_closed
			display_text("You distracted %s" % slime.name)
			await textbox_closed
		elif sucess == 2:
			display_text("You failed to defend!!!")
			await textbox_closed
			current_player_health = max(0, current_player_health - (slime.damage/2))
			set_health($PlayerPanel/PlayerData/ProgressBar, current_player_health, StateH.max_health)
			$AnimationPlayer.play("shake")
			display_text("%s dealt %d damage!" % [slime.name, (slime.damage/2)])
			await textbox_closed
		else:
			display_text("You failed to defend!!!")
			await textbox_closed
			display_text("%s is angry!!!" % slime.name)
			await textbox_closed
			current_player_health = max(0, current_player_health - slime.damage)
			set_health($PlayerPanel/PlayerData/ProgressBar, current_player_health, StateH.max_health)
			$AnimationPlayer.play("shake")
			display_text("%s dealt %d damage!" % [slime.name, slime.damage])
			await textbox_closed
	elif is_running:
		is_running = false
		$AnimationPlayer.play("mini_shake")
		var numbers = [0, 1, 2, 4, 5]
		var sucess = numbers[randi() % numbers.size()]
		if sucess == 1:
			if Global.escape_a == false:
				Global.escape_a = true
				$Trophy.show()
				$ColorRect.show()
				$AudioStreamPlayer2D2.play()
				await get_tree().create_timer(1.5).timeout
				$Trophy.hide()
				$ColorRect.hide()
			display_text("You escaped successfully!")
			await textbox_closed
			await get_tree().create_timer(1.0).timeout	
			get_tree().change_scene_to_file("res://scene_3_1.tscn")
		else:
			display_text("You failed to escape!!!")
			await textbox_closed
			display_text("%s is angry!!!" % slime.name)
			await textbox_closed
			current_player_health = max(0, current_player_health - slime.damage)
			set_health($PlayerPanel/PlayerData/ProgressBar, current_player_health, StateH.max_health)
			$AnimationPlayer.play("shake")
			display_text("%s dealt %d damage!" % [slime.name, slime.damage])
			await textbox_closed
	else:
		var numbers = [0, 1, 2, 3]
		var sucess = numbers[randi() % numbers.size()]
		if sucess == 1:
			display_text("%s doesn't feel satified!" % slime.name)
			await textbox_closed
			display_text("More!!!")
			await textbox_closed
			
			current_player_health = max(0, current_player_health - (slime.damage / 2))
			set_health($PlayerPanel/PlayerData/ProgressBar, current_player_health, StateH.max_health)
			$AnimationPlayer.play("shake")
			display_text("%s dealt %d damage!" % [slime.name, (slime.damage / 2)])
			await textbox_closed
		else:
			display_text("%s doesn't feel satified!" % slime.name)
			await textbox_closed
			display_text("More!!!")
			await textbox_closed
			
			current_player_health = max(0, current_player_health - slime.damage)
			set_health($PlayerPanel/PlayerData/ProgressBar, current_player_health, StateH.max_health)
			$AnimationPlayer.play("shake")
			display_text("%s dealt %d damage!" % [slime.name, slime.damage])
			await textbox_closed
	$ActionsPanel.show()
	



func _on_feed_pressed():
	display_text("In 3 seconds")
	await textbox_closed
	display_text("Aim to feed %s" % slime.name)
	await textbox_closed
	display_text("Press 'E' to shoot")
	await textbox_closed
	$Timer.start()
	$CombatBar.show()
	$CombatSlimebar.show()

func _on_defend_pressed():
	is_defending = true
	
	display_text("You prepare defensively!")
	await textbox_closed
	display_text("You try to distract %s" % slime.name)
	await textbox_closed
	
	await get_tree().create_timer(0.5).timeout
	
	slime_turn()


func _on_run_pressed():
	is_running = true
	
	display_text("You try to run")
	await textbox_closed

	await get_tree().create_timer(0.5).timeout	
	slime_turn()


func _on_timer_timeout():
	$Timer.stop()
	if Global.apple == true:
		Global.apple = false
		display_text("You throw an apple")
		await textbox_closed
		current_slime_hunger = max(0, current_slime_hunger - StateH.damage)
		set_hunger($SlimeContainer/ProgressBar, current_slime_hunger, slime.hunger)
		$SlimeEat.play("eat")
		await get_tree().create_timer(1.0).timeout
	elif Global.miss == true:
		Global.miss = false
		display_text("You throw an apple")
		await textbox_closed
		display_text("You miss")
		await textbox_closed
	else:
		display_text("You didn't do anything")
		await textbox_closed
		
	
	slime_turn()
		
