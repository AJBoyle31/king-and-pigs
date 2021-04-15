extends PigState

func enter(msg := {}) -> void:
	print("Dead State")
	pig.pacingTimer.paused = true
	pig.idleTimer.paused = true
	pig.animation_state_machine.travel("Dead")
	pig.change_animation("Dead")
	yield(get_tree().create_timer(0.9), "timeout")
	pig.queue_free()

func physics_update(delta: float) -> void:
	pass
