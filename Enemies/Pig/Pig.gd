extends KinematicBody2D
class_name Pig

export var speed := 45.0
export var gravity := 500.0
export var jump_impulse := 120.0
export var direction := 1
var velocity = Vector2.ZERO
var previous_velocity = Vector2.ZERO
var flip_player = true
var animation_state_machine
var current_animation

onready var fsm := $StateMachine
onready var animationPlayer = $AnimationPlayer
onready var animations = $Animations
onready var playerDetectionZone = $PlayerDetectionZone
onready var pacingTimer = $PacingTimer
onready var idleTimer = $IdleTimer

func _ready():
	animation_state_machine = $AnimationTree.get("parameters/playback")

func _process(delta):
	get_sprite_facing_direction()

func get_sprite_facing_direction() -> void:
	if flip_player:
		current_animation.scale.x = -1
		animations.position.x = 2.5
	else:
		current_animation.scale.x = 1
		animations.position.x = -2.5
		


func change_animation(anim_name: String) -> void:
	for animation in animations.get_children():
		if animation.name != anim_name:
			animation.hide()
		else:
			current_animation = animation
	get_sprite_facing_direction()
	current_animation.show()
	#print(current_animation.name)


func _on_IdleTimer_timeout():
	flip_player = !flip_player

func _on_PacingTimer_timeout():
	direction *= -1
