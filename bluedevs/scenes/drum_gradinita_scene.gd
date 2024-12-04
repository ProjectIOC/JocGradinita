extends Node2D

@onready var replies = [
	$Reply1,
	$Reply2,
	$Reply3,
	$Reply4
]

@onready var characters = [
	$Character1,
	$Character2,
]

var target_positions = [
	Vector2(860, 400),  # Target position for Character1
	Vector2(890, 400)   # Target position for Character2
]

var character_velocities = []  # Velocities for each character
var current_index = 0
var all_replies_done = false  # Flag to indicate when replies are finished

func _ready():
	# Ensure only the first reply is visible initially
	for i in range(replies.size()):
		replies[i].visible = (i == 0)

	# Connect the Timer's timeout signal to the change_reply function
	$Timer.connect("timeout", Callable(self, "_on_Timer_timeout"))

func _on_Timer_timeout():
	if all_replies_done:
		return  # No further action if replies are done

	# Hide the current reply
	replies[current_index].visible = false

	# Move to the next reply
	current_index += 1

	if current_index >= replies.size():
		# All replies are done, stop the timer and move characters
		$Timer.stop()
		all_replies_done = true
		move_characters()
	else:
		# Show the next reply
		replies[current_index].visible = true

func move_characters():
	character_velocities = []  # Reset velocities
	for i in range(characters.size()):
		var character = characters[i]
		var direction = (target_positions[i] - character.global_position).normalized()
		var speed = 100  # Adjust the speed as necessary
		character_velocities.append(direction * speed)

func _physics_process(delta):
	for i in range(characters.size()):
		if i >= character_velocities.size():
			continue

		var character = characters[i]
		var velocity = character_velocities[i]

		# Move the character smoothly toward the target
		var new_position = character.global_position + velocity * delta

		# Stop moving if the character reaches the target
		if character.global_position.distance_to(target_positions[i]) < 5:
			character.global_position = target_positions[i]
			character_velocities[i] = Vector2()  # Stop movement
		else:
			character.global_position = new_position
