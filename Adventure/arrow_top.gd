extends TextureButton

func _ready():
	# Không cần gọi $ArrowTop vì bạn đang gắn script trực tiếp vào nó rồi!
	mouse_entered.connect(func(): modulate = Color(0.7, 0.7, 0.7))
	mouse_exited.connect(func(): modulate = Color(1, 1, 1))
