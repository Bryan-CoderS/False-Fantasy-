extends Sprite2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	translate(Vector2(1,0) * 1000 * delta)
	
func _on_area_2d_body_entered(body):
	if body.name == "Player":
		# stop the process function so, bullet don't move 
		set_process(false)
		body.take_damage()
		# wait for 0.2 seconds
		await  get_tree().create_timer(0.2).timeout
		# delete the bullet
		queue_free()
	elif body.name == "Wall":
		queue_free()
	elif body.name == "Wall2":
		queue_free()
	elif body.name == "Wall3":
		queue_free()
	elif body.name == "Wall4":
		queue_free()
	elif body.name == "Wall5":
		queue_free()
	elif body.name == "Wall6":
		queue_free()
	elif body.name == "Wall7":
		queue_free()
	elif body.name == "Wall8":
		queue_free()
	elif body.name == "Wall9":
		queue_free()
	elif body.name == "Wall10":
		queue_free()
	elif body.name == "Wall11":
		queue_free()
	elif body.name == "Wall12":
		queue_free()
	elif body.name == "Wall13":
		queue_free()
	elif body.name == "Wall14":
		queue_free()
	else:
		pass


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()



