extends Control
class_name HealthBar
@export var back_color: Color
@export var fill_color: Color
func _ready() -> void:
	var back_style :StyleBox = $ProgressBar.get_theme_stylebox("background").duplicate()
	back_style.bg_color = back_color
	var fill_style :StyleBox = $ProgressBar.get_theme_stylebox("fill").duplicate()
	fill_style.bg_color = fill_color
	$ProgressBar.add_theme_stylebox_override("background",back_style)
	$ProgressBar.add_theme_stylebox_override("fill",fill_style)
func update_bar(value : float,health : float):
	$ProgressBar.value = value
	$Health.text = str(health)


func _on_health_component_on_health_changed(current: float, max: float) -> void:
		var value = current/max
		update_bar(value,current)
