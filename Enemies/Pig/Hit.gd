extends PigState

func enter(msg := {}) -> void:
	print("Hit State")
	pig.pacingTimer.paused = true
	pig.idleTimer.paused = true
	pig.animation_state_machine.travel("Hit")
	pig.change_animation("Hit")
	yield(get_tree().create_timer(0.4), "timeout")
	pig.hit = false
	if pig.dead:
		state_machine.transition_to("Dead")
	elif pig.playerDetectionZone.can_see_player():
		state_machine.transition_to("Chase")
	else:
		state_machine.transition_to("Patrol")

func physics_update(delta: float) -> void:
	pass
