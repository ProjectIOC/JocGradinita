extends  Button

func _ready():
	self.pressed.connect(_button_pressed)

func _button_pressed():
	print("Loading new scene...")  # Debug message
	print("asfdsdvfd: ",get_parent())
	get_parent().get_tree().change_scene_to_file("res://scenes/open_after_start.tscn")
