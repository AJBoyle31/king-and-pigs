extends PlayerState


# If we get a message asking us to jump, we jump.
func enter(msg := {}) -> void:
	if msg.has("do_jump"):
		player.velocity.y = -player.jump_impulse


func physics_update(delta: float) -> void:
	# Horizontal movement.
	var input_direction_x: float = player.get_input_direction()
	player.velocity.x = player.speed * input_direction_x
	# Vertical movement.
	player.velocity.y += player.gravity * delta
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP)
	
	if player.velocity.y < 0:
		player.animation_state_machine.travel("Jump")
		player.change_animation("Jump")
	elif player.velocity.y > 0:
		player.animation_state_machine.travel("Fall")
		player.change_animation("Fall")
	

	# Landing.
	if player.is_on_floor():
		player.animation_state_machine.travel("Ground")
		player.change_animation("Ground")
		yield(get_tree().create_timer(0.1), "timeout")
		
		if is_equal_approx(player.velocity.x, 0.0):
			state_machine.transition_to("Idle")
		else:
			state_machine.transition_to("Run")
