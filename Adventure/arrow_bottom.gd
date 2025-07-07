extends TextureButton


func _ready():

	mouse_entered.connect(func(): modulate = Color(0.7, 0.7, 0.7))
	mouse_exited.connect(func(): modulate = Color(1, 1, 1))
