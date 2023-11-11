extends Sprite2D


func _process(delta):
	translate(Vector2(-1,0) * 1000 * delta)

func _on_area_2d_body_entered(body):
	if body.name == "Player":
		# stop the process function so, bullet don't move 
		set_process(false)
		body.take_damage()
		# wait for 0.2 seconds
		await  get_tree().create_timer(0.2).timeout
		# delete the bullet
		queue_free()
	else:
		pass


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
