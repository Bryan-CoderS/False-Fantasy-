extends CharacterBody2D

const SPEED = 300.0

var facing_direction = Vector2(1, 0)
const PUSH_FORCE = 300
var push_direction = Vector2(1, 0)

@onready var crate = $Crate
#var pushing = false
#@onready var sprite = $Crate
#
#func push(direction):
#	if pushing:
#		return
#
#	pushing = true
#	var tween = get_tree().create_tween()
#	tween.interpolate_value(
#		self, 'global_position', 
#		sprite.position + Vector2(64.0, 64.0), 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
#	)
#	tween.start()


func _on_area_2d_body_entered(body):
	get_crate_in_front()
	var push_vector = push_direction.normalized()
	$Crate.push_crate(push_vector * PUSH_FORCE)
	
	
func get_crate_in_front():
	# Cast a ray to check if there's a crate in front of the player.
	# Return the reference to the crate if found, otherwise return null.
	var ray_length = 32
	var ray_origin = global_position
	var ray_destination = ray_origin + push_direction * ray_length
	var ray_result = move_and_collide(ray_destination - ray_origin)
	if ray_result and ray_result.get_collider:  # Assuming the crate is in the "crates" group.
		return ray_result.get_collider
		return null
			
func push_crate(push_vector: Vector2):
	if crate:
		push_vector = facing_direction.normalized()
		crate.push_crate(push_vector * PUSH_FORCE)
