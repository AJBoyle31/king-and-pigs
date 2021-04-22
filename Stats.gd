extends Node

# Export a variable called max_health that is easily adjustable in the editor
export var max_health = 4

# When the scene is loaded, we set the health variable to equal what the max_health was set up for in the editor. It needs to be done when the scene is loaded because the editor variable isn't hardcoded (Godot thing) 
# setget is added so that whenever this variable is adjusted in whichever scene it's added to (in this case Bat), it calls the set_health function and passes an argument of the new variable 
onready var health = max_health setget set_health

# A new signal is created called no_health
signal no_health

# The function called in the setget above which takes an argument named value. Value is the equal to what the change to the variable made in the scene this node is attached to. If the health is less than or equal to zero, we emit the no_health signal to let the parent node know there is no more health.
func set_health(value):
	health = value
	print("Health: " + str(health))
	if health <= 0:
		emit_signal("no_health")
