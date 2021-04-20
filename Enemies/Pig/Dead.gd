extends PigState

func enter(msg := {}) -> void:
	print("Dead State")
	pig.pacingTimer.paused = true
	pig.idleTimer.paused = true
	pig.animation_state_machine.travel("Dead")
	pig.change_animation("Dead")
	pig.animationTimer.start(0.9)
	

func physics_update(delta: float) -> void:
	if pig.nextState:
		pig.queue_free()
