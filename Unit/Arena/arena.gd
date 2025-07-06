extends Node2D

class_name Arena
@export var player : Player
@export var normal_color: Color
@export var blocked_color: Color
@export var critical_color: Color
@export var hp_color: Color
@onready var uprade_panel = $GameUI/ShopPanel
@onready var wavetime = $GameUI/WaveTimeLabel 
@onready var waveindex = $GameUI/WaveIndexLabel
@onready var spawner = $Spawner
func _process(delta: float) -> void:
	if Global.game_paused : return
	waveindex.text = spawner.get_wave_text()
	wavetime.text = spawner.get_wave_timer_text()


func _ready() -> void:
	Global.player = player
	Global.on_create_block_text.connect(_on_create_block_text)
	Global.on_create_damage_text.connect(_on_create_damage_text)
	Global.on_upgrade_selected.connect(_on_upgrade_selected)
	spawner.start_wave()
func create_floating_text(unit : Node2D) -> FloatingText:
	var instance := Global.FLOATING_TEXT_SCENE.instantiate() as FloatingText
	get_tree().root.add_child(instance)
	var random_pos := randf_range(0,TAU) * 35
	var spawn_pos := unit.global_position + Vector2.RIGHT.rotated(random_pos)
	instance.global_position = spawn_pos
	return instance
	
func show_upgrade():
	uprade_panel.show()
	
func start_new_wave():
	Global.game_paused = false
	spawner.wave_index += 1
	spawner.start_wave()
	
func _on_create_block_text(unit : Node2D):
	var text = create_floating_text(unit)
	text.setup("Blocked!", blocked_color)
func _on_create_damage_text(unit : Node2D,hitbox:HitboxComponent):
	var text = create_floating_text(unit)
	var color := critical_color if hitbox.critical else normal_color
	text.setup(str(hitbox.damage), color)

func _on_upgrade_selected():
	uprade_panel.hide()
	start_new_wave()
	

func _on_spawner_on_wave_conpleted() -> void:
	if not Global.player: return
	await get_tree().create_timer(1.0).timeout
	show_upgrade()
