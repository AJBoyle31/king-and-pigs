extends PigState

func enter(_msg := {}) -> void:
	print("Idle State")
	pig.velocity = Vector2.ZERO
	pig.pacingTimer.paused = true
	pig.idleTimer.paused = false
	pig.animation_state_machine.travel("Idle")
	pig.change_animation("Idle")
	yield(get_tree().create_timer(2), "timeout")
	state_machine.transition_to("Patrol")

func physics_update(_delta: float) -> void:
	
	if pig.hit:
		state_machine.transition_to("Hit")
		return
	
	if not pig.is_on_floor():
		state_machine.transition_to("Air")
		return
	
	if pig.velocity.x > 0:
		state_machine.transition_to("Run")


#	if Input.is_action_just_pressed("jump"):
#		state_machine.transition_to("Air", {do_jump = true})
#	elif Input.is_action_pressed("run_left") or Input.is_action_pressed("run_right"):
#		state_machine.transition_to("Run")
#	elif Input.is_action_just_pressed("attack"):
#		state_machine.transition_to("Attack", {attack = true})
