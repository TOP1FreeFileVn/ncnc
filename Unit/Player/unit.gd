extends Node2D
class_name Unit 
@onready var visuals = %Visual
@onready var sprites = %Sprite
@onready var anm = $AnimationPlayer
@export var stats : UnitStats
@onready var health = $HealthComponent
func _ready() -> void:
	health.setup(stats)

func setflashmat():
	sprites.material = Global.FLASH_MAT
	$FlashTimer.start()
func _on_hurt_box_component_on_damaged(hitbox: HitboxComponent) -> void:
	if health.current_health <= 0:
		return
	var blocked := Global.get_chance_success(stats.block_chance/100)
	if blocked:
		Global.on_create_block_text.emit(self)
		return
	setflashmat()
	health.take_damage(hitbox.damage)
	Global.on_create_damage_text.emit(self,hitbox)



func _on_flash_timer_timeout() -> void:
	sprites.material = null
