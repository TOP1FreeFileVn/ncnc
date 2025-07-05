extends Node
const FLASH_MAT = preload("res://Unit/VFX/flash_material.tres")
const FLOATING_TEXT_SCENE = preload("res://Unit/FloatingText/floating_text.tscn")
signal on_create_block_text(unit: Node2D)
signal on_create_damage_text(unit: Node2D,hitbox : HitboxComponent)
signal on_upgrade_selected
var player: Player
var coin: int = 1000000000
enum UpgradeTier{
	COMMON,
	RARE,
	EPIC,
	LEGENDARY
}
var game_paused = false 
func get_chance_success(chance:float) -> bool:
	var random := randf_range(0,1.0)
	if random < chance:
		return true
	return false
