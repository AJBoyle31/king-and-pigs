extends PigState

func enter(_msg := {}) -> void:
	print("Idle State")
	pig.velocity = Vector2.ZERO
	pig.animation_state_machine.travel("Idle")
	pig.change_animation("Idle")


func physics_update(_delta: float) -> void:
	
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
