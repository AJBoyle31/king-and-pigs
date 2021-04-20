extends PigState

func enter(_msg := {}) -> void:
	print("Patrol State")
	pig.pacingTimer.paused = false
	pig.idleTimer.paused = true
	pig.animation_state_machine.travel("Run")
	pig.change_animation("Run")
	

func physics_update(delta: float) -> void:
	if pig.hit:
		state_machine.transition_to("Hit")
		return
	if not pig.is_on_floor():
		state_machine.transition_to("Air")
		return
	if pig.playerDetectionZone.can_see_player():
		state_machine.transition_to("Chase")
	if pig.is_on_wall():
		pig.pacingTimer.paused = true
		pig.direction *= -1
	
		
	pig.velocity.x = pig.speed * pig.direction
	if pig.velocity.x > 0:
		pig.flip_player = true
	elif pig.velocity.x < 0:
		pig.flip_player = false
	
	pig.velocity.y += pig.gravity * delta
	pig.velocity = pig.move_and_slide(pig.velocity, Vector2.UP)
	
	
	


