extends Panel
class_name UpgradePanel
const UPGRADE_CARD_SCENE = preload("res://Ui_control_player/UpgradeCard/upgrade_card.tscn")
const Stats = preload("res://Ui_control_player/stats_cotainer.tscn")
@export var upgrade_list: Array[ItemUpgrade]
@onready var item_container : VBoxContainer = %ItemContainer

func _ready() -> void:
	load_upgrade()

func load_upgrade():
	for child in item_container.get_children():
		child.queue_free()
	for i in 4:
		var upg := upgrade_list.pick_random() as ItemUpgrade
		var upg_instance := UPGRADE_CARD_SCENE.instantiate() as UpradeCard
		item_container.add_child(upg_instance)
		upg_instance.item_data = upg
	var stats = Stats.instantiate()
	item_container.add_child(stats)
	
