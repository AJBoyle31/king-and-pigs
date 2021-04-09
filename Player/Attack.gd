extends PlayerState


# If we get a message asking us to jump, we jump.
func enter(msg := {}) -> void:
	if msg.has("attack"):
		player.animation_state_machine.travel("Attack")
		player.change_animation("Attack")
		yield(get_tree().create_timer(0.4), "timeout")
		if is_equal_approx(player.velocity.x, 0.0):
			state_machine.transition_to("Idle")
		else:
			state_machine.transition_to("Run")

func physics_update(delta: float) -> void:
	pass
