extends Button


func _ready():
	self.connect("pressed", func(): modulate = Color(0.7, 0.7, 0.7))
	self.connect("button_up", func(): modulate = Color(1, 1, 1))
