extends PigState

func enter(msg := {}) -> void:
	print("Hit State")
	pig.pacingTimer.paused = true
	pig.idleTimer.paused = true
	pig.animation_state_machine.travel("Hit")
	pig.change_animation("Hit")
	pig.animationTimer.start(0.4)
	

func physics_update(delta: float) -> void:
	if pig.nextState:
		pig.nextState = false
		pig.hit = false
		if pig.dead:
			state_machine.transition_to("Dead")
		elif pig.playerDetectionZone.can_see_player():
			state_machine.transition_to("Chase")
		else:
			state_machine.transition_to("Patrol")
