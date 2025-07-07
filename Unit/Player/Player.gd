extends Unit
class_name Player 
var move_dir: Vector2
@onready var weapon_container = $WeaponContainer
var current_weapon: Array[Weapon] = []
func _ready() -> void:
	super._ready()
	add_weapon(preload("res://Resource/Units/Item/Weapon/Melee/Chainsaw/chainsaw.tres"))
func is_facing_right()-> bool:
	return visuals.scale.x == -0.5
func _process(delta: float) -> void:
	if Global.game_paused : return
	move_dir = Input.get_vector("left","right","up","down")
	var current_velocity = move_dir*500
	position += current_velocity*delta
	position.x = clamp(position.x,-1000,1000)
	position.y = clamp(position.y,-500,500)
	update_animations()
	update_rotation()
	
func update_player_new_wave():
	stats.health += stats.health_increase_per_wave
	
func add_weapon(data: ItemWeapon):
	var weapon := data.scene.instantiate() as Weapon
	add_child(weapon)
	weapon.setup_weapon(data)
	current_weapon.append(weapon)
	weapon_container.update_weapon_position(current_weapon)
func update_animations() :
	if move_dir.length() > 0:
		anm.play("move")
	else :
		anm.play("idle")
func update_rotation():
	if move_dir == Vector2.ZERO:
		return
	elif move_dir.x >= 0.1:
		visuals.scale = Vector2(-0.5,0.5)
	else :
		visuals.scale = Vector2(0.5,0.5)
