extends Panel
class_name UpradeCard

@onready var item_icon:TextureRect = $MarginContainer/Control/HBoxContainer/Icon

@export var item_data =  ItemUpgrade: set = _set_data

@onready var item_name = $MarginContainer/Control/HBoxContainer/VBoxContainer/Name
@onready var itemdes = $MarginContainer/Control/HBoxContainer/VBoxContainer/Name2

func _set_data(value : ItemUpgrade):
	item_data = value
	item_icon.texture = item_data.item_icon
	item_name.text = item_data.item_name
	itemdes.text = item_data.description


func _on_button_pressed() -> void:
	if item_data and is_instance_valid(Global.player):
		item_data.apply_upgrade()
		Global.on_upgrade_selected.emit()
