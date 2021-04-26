extends KingPigState

func enter(msg := {}) -> void:
	print("Attack State")
	kingPig.pacingTimer.paused = true
	kingPig.idleTimer.paused = true
	kingPig.animation_state_machine.travel("Attack")
	kingPig.change_animation("Attack")
	kingPig.animationTimer.start(0.07)
	
	

func physics_update(delta: float) -> void:
	if kingPig.hit:
		state_machine.transition_to("Hit")
		return
	if kingPig.nextState:
		kingPig.nextState = false
		if kingPig.playerDetectionZone.can_see_player():
			state_machine.transition_to("Chase")
		else:
			state_machine.transition_to("Patrol")
