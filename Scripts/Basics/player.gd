extends CharacterBody2D
# This is for moving the player around in the overworld.
# For the player during combat, go to player_action.gd
@export var speed = 400

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed

func _physics_process(_delta):
	get_input()
	move_and_slide()
