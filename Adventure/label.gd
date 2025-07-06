extends Label




@onready var music_slider = $Control/MusicSlider
@onready var sfx_slider = $Control/SFXSlider

func _ready():
	music_slider.value_changed.connect(_on_music_slider_value_changed)
	sfx_slider.value_changed.connect(_on_sfx_slider_value_changed)

func _on_music_slider_value_changed(value: float) -> void:
	var db = linear_to_db(value)
	var bus_index = AudioServer.get_bus_index("Music")
	AudioServer.set_bus_volume_db(bus_index, db)

func _on_sfx_slider_value_changed(value: float) -> void:
	var db = linear_to_db(value)
	var bus_index = AudioServer.get_bus_index("SFX")
	AudioServer.set_bus_volume_db(bus_index, db)

func linear_to_db(value: float) -> float:
	return -80.0 if value <= 0.01 else 20.0 * log(value) / log(10)
