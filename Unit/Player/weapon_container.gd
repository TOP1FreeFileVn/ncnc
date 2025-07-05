extends Node2D
class_name WeaponContainer
@onready var One = $One
@onready var Two = $Two
@onready var  Three = $Three
@onready var Four = $Four
@onready var Five = $Five
@onready var Six = $Six
func update_weapon_position(weapon: Array[Weapon]) -> void:
	var count := weapon.size()
	var reference_node:  Node2D
	match count:
		1: reference_node  = One
		2: reference_node = Two
		3: reference_node = Three
		4: reference_node  = Four
		5: reference_node = Five
		6: reference_node = Six
	var markers := reference_node.get_children()
	if markers.size() != count:
		return
	for i in count:
		weapon[i].global_position = markers[i].global_position 
