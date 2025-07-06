extends Control












func _on_equipment_pressed() -> void:
	get_tree().change_scene_to_file("res://Equipment/Equipment.tscn")


func _on_achievement_pressed() -> void:
	get_tree().change_scene_to_file("res://Achievement/Achievement.tscn")


func _on_event_pressed() -> void:
	get_tree().change_scene_to_file("res://Event/Event.tscn")


func _on_shop_pressed() -> void:
	get_tree().change_scene_to_file("res://Shop/Shop.tscn")


var current_map_index := 0
var maps := []

func _ready():
	# Trỏ đúng đến các node bản đồ
	maps = [
		$TextureRect/Map/Map1,
		$TextureRect/Map/Map2,
		$TextureRect/Map/Map3
	]

	# Ẩn các map trừ map đầu tiên
	_update_visible_map()

	# Gắn sự kiện cho nút mũi tên
	$TextureRect/Arrow/ArrowTop.pressed.connect(_on_arrow_top_pressed)
	$TextureRect/Arrow/ArrowBottom.pressed.connect(_on_arrow_bottom_pressed)

func _update_visible_map():
	for i in range(maps.size()):
		maps[i].visible = (i == current_map_index)

func _on_arrow_top_pressed():
	current_map_index -= 1
	if current_map_index < 0:
		current_map_index = maps.size() - 1
	_update_visible_map()

func _on_arrow_bottom_pressed():
	current_map_index += 1
	if current_map_index >= maps.size():
		current_map_index = 0
	_update_visible_map()
