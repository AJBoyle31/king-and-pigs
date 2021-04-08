extends KinematicBody2D
class_name Player

export var speed := 150.0
export var gravity := 500.0
export var jump_impulse := 195.0
var velocity
var previous_velocity = Vector2.ZERO
var flip_player = false
var animation_state_machine
var current_animation

onready var fsm := $StateMachine
onready var animationPlayer = $AnimationPlayer
onready var animations = $Animations
onready var hitboxPivot = $HitboxPivot
onready var hammerHitbox = $HitboxPivot/HammerHitbox

func _ready():
	animation_state_machine = $AnimationTree.get("parameters/playback")

func _process(delta):
	get_sprite_facing_direction()

#var speed: = Vector2(150.0, 200.0)
#export var GRAVITY: int = 500
#var state_machine
#
#var _velocity: = Vector2.ZERO
#var _previous_velocity: = Vector2.ZERO
#var _previous_animation: bool = false
#var current_animation
#var did_land: bool = false
#const FLOOR_NORMAL: = Vector2.UP
#

#
#func get_direction() -> Vector2:
#	return Vector2(
#		Input.get_action_strength("run_right") - Input.get_action_strength("run_left"),
#		-Input.get_action_strength("jump") if is_on_floor() and Input.is_action_just_pressed("jump") else 0.0
#	)
#
#func calculate_move_velocity(
#		linear_velocity: Vector2,
#		direction: Vector2,
#		speeds: Vector2,
#		is_jump_interrupted: bool
#	) -> Vector2:
#	var velocity: = linear_velocity
#	velocity.x = speeds.x * direction.x
#	if direction.y != 0.0:
#		velocity.y = speeds.y * direction.y
#	if is_jump_interrupted:
#		velocity.y = 0.0
#	return velocity
#
#func move_state(delta):
#	var is_jump_interrupted = Input.is_action_just_released("jump") and _velocity.y < 0.0
#	var direction = get_direction()
#	if direction != Vector2.ZERO:
#		_velocity = calculate_move_velocity(_velocity, direction, speed, is_jump_interrupted)
#		_previous_velocity = _velocity
#	else:
#		_velocity = calculate_move_velocity(_velocity, Vector2.ZERO, Vector2.ZERO, false)
#	_velocity.y += GRAVITY * delta
#
#	move()
#
#func move():
#	var snap: Vector2 = Vector2.DOWN * 60.0 if _velocity.y == 0.0 else Vector2.ZERO
#	_velocity = move_and_slide_with_snap(_velocity, snap, FLOOR_NORMAL, true)
#
#	
#
#	

func get_input_direction() -> float:
	return (
		Input.get_action_strength("run_right")
		- Input.get_action_strength("run_left")
	)
	

func get_sprite_facing_direction() -> void:
	if flip_player:
		current_animation.scale.x = -1
		animations.position.x = -7
		hitboxPivot.position.x = -35
	else:
		current_animation.scale.x = 1
		animations.position.x = 7
		hitboxPivot.position.x = 35
		


func change_animation(anim_name: String) -> void:
	for animation in animations.get_children():
		if animation.name != anim_name:
			animation.hide()
		else:
			current_animation = animation
	get_sprite_facing_direction()
	current_animation.show()
	#print(current_animation.name)




func _on_AnimationPlayer_animation_finished(anim_name):
	pass # Replace with function body.
