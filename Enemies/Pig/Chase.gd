extends PigState

func physics_update(delta: float) -> void:
	print("Chase State")
	pig.pacingTimer.paused = true
	if pig.hit:
		state_machine.transition_to("Hit")
		return
#	if not pig.is_on_floor():
#		state_machine.transition_to("Air")
#		return
	
	var player = pig.playerDetectionZone.player
	if player != null:
		var distance_apart = player.global_position.x - pig.global_position.x 
		if distance_apart < 25 and distance_apart > -25:
			state_machine.transition_to("Attack")
			return
		else:
			pig.direction = 1 if distance_apart > 0 else -1
	else:
		state_machine.transition_to("Patrol")
		return
	
	

	pig.velocity.x = pig.speed * pig.direction
	if pig.velocity.x > 0:
		pig.flip_player = true
	elif pig.velocity.x < 0:
		pig.flip_player = false
	
	pig.velocity.y += pig.gravity * delta
	pig.velocity = pig.move_and_slide(pig.velocity, Vector2.UP)
	
	pig.animation_state_machine.travel("Run")
	pig.change_animation("Run")
	
	

#	if Input.is_action_just_pressed("jump"):
#		state_machine.transition_to("Air", {do_jump = true})
#	elif is_equal_approx(input_direction_x, 0.0):
#		state_machine.transition_to("Idle")
#	elif Input.is_action_just_pressed("attack"):
#		state_machine.transition_to("Attack", {attack = true})


