extends PigState


# If we get a message asking us to jump, we jump.
func enter(msg := {}) -> void:
	print("Air State")

func physics_update(delta: float) -> void:
	
	# Horizontal movement.
	
	# Vertical movement.
	pig.velocity.y += pig.gravity * delta
	pig.velocity = pig.move_and_slide(pig.velocity, Vector2.UP)
	
	if pig.velocity.y < 0:
		pig.animation_state_machine.travel("Jump")
		pig.change_animation("Jump")
	elif pig.velocity.y > 0:
		pig.animation_state_machine.travel("Fall")
		pig.change_animation("Fall")
	

	# Landing.
	if pig.is_on_floor():
		pig.animation_state_machine.travel("Ground")
		pig.change_animation("Ground")
		yield(get_tree().create_timer(0.1), "timeout")
		state_machine.transition_to("Idle")
		
