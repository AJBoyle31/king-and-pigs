extends KinematicBody2D

var speed: = Vector2(250.0, 250.0)
export var GRAVITY: int = 500

var _velocity: = Vector2.ZERO
var current_animation
const FLOOR_NORMAL = Vector2.UP

enum {
	IDLE,
	RUN,
	ATTACK,
	HURT
}


onready var animations = $Animations
onready var animationPlayer = $AnimationPlayer

func _physics_process(delta):
	var is_jump_interrupted: = Input.is_action_just_released("jump") and _velocity.y < 0.0
	var direction = get_direction()
	_velocity = calculate_move_velocity(_velocity, direction, speed, is_jump_interrupted)
	_velocity.y += GRAVITY * delta
	var snap: Vector2 = Vector2.DOWN * 60.0 if direction.y == 0.0 else Vector2.ZERO
	
	if direction.x < 0:
		current_animation.flip_h = true
	elif direction.x > 0:
		current_animation.flip_h = false
	
	if _velocity.x > 0 or _velocity.x < 0:
		animationPlayer.play("Run")
	elif _velocity.x == 0:
		animationPlayer.play("Idle")
	
	_velocity = move_and_slide_with_snap(_velocity, snap, FLOOR_NORMAL, true)

func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("run_right") - Input.get_action_strength("run_left"),
		-Input.get_action_strength("jump") if is_on_floor() and Input.is_action_just_pressed("jump") else 0.0
	)

func calculate_move_velocity(
		linear_velocity: Vector2,
		direction: Vector2,
		speed: Vector2,
		is_jump_interrupted: bool
	) -> Vector2:
	var velocity: = linear_velocity
	velocity.x = speed.x * direction.x
	if direction.y != 0.0:
		velocity.y = speed.y * direction.y
	if is_jump_interrupted:
		velocity.y = 0.0
	return velocity




func _change_animation(state: String) -> void:
	for animation in animations.get_children():
		if animation.name != state:
			animation.hide()
		else:
			current_animation = animation
	current_animation.show()

func _on_AnimationPlayer_animation_started(anim_name):
	_change_animation(anim_name)
	
