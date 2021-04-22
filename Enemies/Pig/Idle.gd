extends PigState

func enter(_msg := {}) -> void:
	print("Idle State")
	pig.velocity = Vector2.ZERO
	pig.pacingTimer.paused = true
	pig.idleTimer.paused = false
	pig.animation_state_machine.travel("Idle")
	pig.change_animation("Idle")
	if pig.patrol:
		pig.animationTimer.start(2.0)
	


func physics_update(_delta: float) -> void:
	
	if pig.nextState and pig.patrol:
		pig.nextState = false
		state_machine.transition_to("Patrol")
	
	if pig.hit:
		pig.idleTimer.paused = true
		state_machine.transition_to("Hit")
		return
	
	if not pig.is_on_floor():
		pig.idleTimer.paused = true
		state_machine.transition_to("Air")
		return
	
	if pig.playerDetectionZone.can_see_player():
		pig.idleTimer.paused = true
		state_machine.transition_to("Chase")
	
		


