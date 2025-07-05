extends Panel
class_name ShopPanel
const SHOP_CARD_SCENE = preload("res://Ui_control_player/ShopCard/shopcard.tscn")
@export var shop_item: Array[ItemBase]

func loadshop(current_wave : int):
	for child in $MarginContainer/Control/ItemContainer.get_children() : child.queue_free()
	
