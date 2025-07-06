extends Panel
class_name ShopCard
@onready var item = %Itemicon
@export var shop_item: ItemBase : set = _set_shop_item
signal on_item_purchased

func _set_shop_item(value : ItemBase) :
	shop_item = value
	item.texture = value.item_icon


func _on_button_pressed() -> void:
	on_item_purchased.emit()
	queue_free()
