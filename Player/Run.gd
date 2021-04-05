extends PlayerState


func physics_update(delta: float) -> void:
	if not player.is_on_floor():
		state_machine.transition_to("Air")
		return

	
	var input_direction_x: float = player.get_input_direction()
	player.velocity.x = player.speed * input_direction_x
	if player.velocity.x > 0:
		player.flip_player = false
	elif player.velocity.x < 0:
		player.flip_player = true
	
	player.velocity.y += player.gravity * delta
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP)
	
	player.animation_state_machine.travel("Run")
	player.change_animation("Run")
	
	

	if Input.is_action_just_pressed("jump"):
		state_machine.transition_to("Air", {do_jump = true})
	elif is_equal_approx(input_direction_x, 0.0):
		state_machine.transition_to("Idle")
