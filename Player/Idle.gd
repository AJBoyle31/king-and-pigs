extends PlayerState

# Upon entering the state, we set the player node's velocity to zero
func enter(_msg := {}) -> void:
	player.velocity = Vector2.ZERO
	player.animation_state_machine.travel("Idle")
	player.change_animation("Idle")


func physics_update(_delta: float) -> void:
	
	if not player.is_on_floor():
		state_machine.transition_to("Air")
		return

	if Input.is_action_just_pressed("jump"):
		state_machine.transition_to("Air", {do_jump = true})
	elif Input.is_action_pressed("run_left") or Input.is_action_pressed("run_right"):
		state_machine.transition_to("Run")
