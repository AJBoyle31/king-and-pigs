extends PigState

func enter(msg := {}) -> void:
	print("Attack State")
	pig.pacingTimer.paused = true
	pig.idleTimer.paused = true
	pig.animation_state_machine.travel("Attack")
	pig.change_animation("Attack")
	yield(get_tree().create_timer(0.7), "timeout")
	if pig.playerDetectionZone.can_see_player():
		state_machine.transition_to("Chase")
	else:
		state_machine.transition_to("Patrol")

func physics_update(delta: float) -> void:
	if pig.hit:
		state_machine.transition_to("Hit")
		return
	
