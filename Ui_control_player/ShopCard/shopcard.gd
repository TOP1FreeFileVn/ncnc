extends Panel
class_name ShopCard
@onready var item = %Itemicon
@export var shop_item: ItemBase : set = _set_shop_item
signal on_item_purchased(item : ItemBase)
func _set_shop_item(value : ItemBase) :
	shop_item = value
	item.texture = value.item_icon
	

func _on_button_pressed() -> void:
	if Global.coin >= shop_item.item_cost:
		Global.coin -= shop_item.item_cost
		on_item_purchased.emit(shop_item)
		queue_free()
