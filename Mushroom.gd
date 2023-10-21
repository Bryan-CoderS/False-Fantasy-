extends Node2D

func be_bounced_upon(bouncer):
	if bouncer.has_method("bounce"):
		bouncer.bounce()
		$MushroomAnim.play("boing")

func _on_area_2d_body_entered(body):
	$MushroomAnim.play("boing")
