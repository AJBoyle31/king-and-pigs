extends PigState

func enter(msg := {}) -> void:
	print("Attack State")
	pig.pacingTimer.paused = true
	pig.idleTimer.paused = true
	pig.animation_state_machine.travel("Attack")
	pig.change_animation("Attack")
	pig.animationTimer.start(0.07)
	
	

func physics_update(delta: float) -> void:
	if pig.hit:
		state_machine.transition_to("Hit")
		return
	if pig.nextState:
		pig.nextState = false
		if pig.playerDetectionZone.can_see_player():
			state_machine.transition_to("Chase")
		else:
			state_machine.transition_to("Patrol")
	
	
	
