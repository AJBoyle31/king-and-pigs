extends KinematicBody2D

var speed: = Vector2(150.0, 200.0)
export var GRAVITY: int = 500

var _velocity: = Vector2.ZERO
var _previous_velocity: = Vector2.ZERO
var _previous_animation: bool = false
var current_animation
var did_land: bool = false
const FLOOR_NORMAL: = Vector2.UP

enum {
	MOVE,
	RUN,
	JUMP,
	FALL,
	ATTACK,
	HURT
}

var state = MOVE


onready var worldCollision = $WorldCollision
onready var animations = $Animations
onready var animationPlayer = $AnimationPlayer

func _physics_process(delta):
	match state:
		MOVE:
			move_state(delta)
		ATTACK:
			attack_state(delta)
		HURT:
			pass
	
	if Input.is_action_just_pressed("attack"):
		state = ATTACK



func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("run_right") - Input.get_action_strength("run_left"),
		-Input.get_action_strength("jump") if is_on_floor() and Input.is_action_just_pressed("jump") else 0.0
	)

func calculate_move_velocity(
		linear_velocity: Vector2,
		direction: Vector2,
		speeds: Vector2,
		is_jump_interrupted: bool
	) -> Vector2:
	var velocity: = linear_velocity
	velocity.x = speeds.x * direction.x
	if direction.y != 0.0:
		velocity.y = speeds.y * direction.y
	if is_jump_interrupted:
		velocity.y = 0.0
	return velocity

func move_state(delta):
	var is_jump_interrupted = Input.is_action_just_released("jump") and _velocity.y < 0.0
	var direction = get_direction()
	if direction != Vector2.ZERO:
		_velocity = calculate_move_velocity(_velocity, direction, speed, is_jump_interrupted)
		_previous_velocity = _velocity
	else:
		_velocity = calculate_move_velocity(_velocity, Vector2.ZERO, Vector2.ZERO, false)
	_velocity.y += GRAVITY * delta
	
	move()

func move():
	var snap: Vector2 = Vector2.DOWN * 60.0 if _velocity.y == 0.0 else Vector2.ZERO
	_velocity = move_and_slide_with_snap(_velocity, snap, FLOOR_NORMAL, true)
	playAnimation(_velocity)
	if _previous_velocity.x < 0:
		current_animation.flip_h = true
		_previous_animation = true
		animations.position.x = -7
	elif _previous_velocity.x > 0:
		current_animation.flip_h = false
		_previous_animation = false
		animations.position.x = 7
	
func attack_state(delta):
	animationPlayer.play("Attack")

func attack_finished():
	state = MOVE

func playAnimation(velocity):
	if velocity.y > 0:
		animationPlayer.play("Fall")
		did_land = true
	elif velocity.y < 0:
		animationPlayer.play("Jump")
	elif did_land and is_on_floor():
		animationPlayer.play("Ground")
		yield(animationPlayer, "animation_finished")
		did_land = false
	elif velocity.x > 0 or velocity.x < 0 and is_on_floor():
		animationPlayer.play("Run")
	elif velocity.x == 0:
		animationPlayer.play("Idle")


func _change_animation(anim_name: String) -> void:
	for animation in animations.get_children():
		if animation.name != anim_name:
			animation.hide()
		else:
			current_animation = animation
	current_animation.show()
	current_animation.flip_h = _previous_animation

func _on_AnimationPlayer_animation_started(anim_name):
	_change_animation(anim_name)
	
