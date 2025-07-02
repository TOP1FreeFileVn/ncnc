extends Node2D
class_name Weapon
@onready var Sprite2d = $Sprite2D
@onready var Area = $RangeArea/CollisionShape2D
@onready var CoolDown = $CooldownTimer

var data: ItemWeapon
var is_attacking := false
var atk_start_pos: Vector2
var targets: Array[Enemy]
var closest_target: Enemy
var weapon_spread: float

func _ready() -> void:
	atk_start_pos = Sprite2d.position
func setup_weapon(data : ItemWeapon):
	self.data = data
	Area.shape.radius = data.stats.max_range
func can_use_weapon() -> bool:
	return CoolDown.is_stopped() and closest_target 

func _on_range_area_area_entered(area: Area2D) -> void:
	targets.push_back(area)


func _on_range_area_area_shape_exited(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	targets.erase(area)
