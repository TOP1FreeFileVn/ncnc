extends Node2D
class_name Weapon
@onready var Sprite2d = $Sprite2D
@onready var Area = $RangeArea/CollisionShape2D
@onready var CoolDown = $CooldownTimer
@onready var weaponBehavior = $WeaponBehavior
var data: ItemWeapon
var is_attacking := false
var atk_start_pos: Vector2
var targets: Array[Enemy]
var closest_target: Enemy
var weapon_spread: float

func _ready() -> void:
	atk_start_pos = Sprite2d.position
func _process(delta: float) -> void:
	if not is_attacking:
		if targets.size() > 0:
			update_closet_target()
		else :
			closest_target = null
	rotate_to_target()
	update_visual()
	if can_use_weapon():
		use_weapon()
func setup_weapon(data : ItemWeapon):
	self.data = data
	Area.shape.radius = data.stats.max_range
func can_use_weapon() -> bool:
	return CoolDown.is_stopped() and closest_target 
func use_weapon():
	calculate_spread()
	weaponBehavior.excute_attack()
	CoolDown.wait_time = data.stats.cooldown
	CoolDown.start()
func _on_range_area_area_entered(area: Area2D) -> void:
	targets.push_back(area)
func update_closet_target():
	closest_target = get_closest_target()
func rotate_to_target():
	if is_attacking:
		rotation = get_custom_rotation_to_target()
	else :
		rotation = get_rotation_target()
func  get_custom_rotation_to_target() -> float :
	if not closest_target or not is_instance_valid(closest_target):
		return rotation
	var rot := global_position.direction_to(closest_target.global_position).angle()
	return rot+weapon_spread
func get_rotation_target()-> float:
	if targets.size() == 0:
		return get_idle_rotation()
	var rot := global_position.direction_to(closest_target.global_position).angle()
	return rot
func _on_range_area_area_shape_exited(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	targets.erase(area)
	if targets.size() == 0:
		closest_target = null
func get_closest_target():
	if targets.size() == 0:
		return
	var closest_enemy := targets[0]
	var closest_distance := global_position.distance_to(closest_enemy.global_position)
	for i in range(1,targets.size()):
		var target: Enemy = targets[i]
		var distance := global_position.distance_to(target.global_position)
		if distance < closest_distance:
			closest_enemy = target 
			closest_distance = distance
	return closest_enemy 
func get_idle_rotation():
	if Global.player.is_facing_right():
		return 0
	else :
		return PI
func calculate_spread():
	weapon_spread += randf_range(-1 + data.stats.accuracy,1- data.stats.accuracy)
	
func update_visual():
	if abs(rotation) > PI / 2:
		Sprite2d.scale.y  = -0.5
	else : 
		Sprite2d.scale.y  = 0.5
