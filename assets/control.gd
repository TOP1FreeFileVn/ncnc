extends Control



func _ready():
	var popup = $MenuButton.get_popup()
	popup.add_item("Mới")       # id = 0
	popup.add_item("Tải")       # id = 1
	popup.add_item("Thoát")     # id = 2

	# Kết nối sự kiện khi chọn 1 mục trong menu
	popup.id_pressed.connect(_on_menu_selected)

func _on_menu_selected(id):
	match id:
		0:
			print("Bắt đầu game mới")
		1:
			print("Tải game")
		2:
			print("Thoát game")
			get_tree().quit()
