extends KingPigState

func enter(_msg := {}) -> void:
	print("Idle State")
	kingPig.velocity = Vector2.ZERO
	kingPig.pacingTimer.paused = true
	kingPig.idleTimer.paused = false
	kingPig.animation_state_machine.travel("Idle")
	kingPig.change_animation("Idle")
	if kingPig.patrol:
		kingPig.animationTimer.start(2.0)
	


func physics_update(_delta: float) -> void:
	
	if kingPig.nextState and kingPig.patrol:
		kingPig.nextState = false
		state_machine.transition_to("Patrol")
	
	if kingPig.hit:
		kingPig.idleTimer.paused = true
		state_machine.transition_to("Hit")
		return
	
	if not kingPig.is_on_floor():
		kingPig.idleTimer.paused = true
		state_machine.transition_to("Air")
		return
	
	if kingPig.playerDetectionZone.can_see_player():
		kingPig.idleTimer.paused = true
		state_machine.transition_to("Chase")
	
