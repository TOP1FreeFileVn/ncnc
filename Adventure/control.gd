extends Button

@onready var base := $Base
@export var max_radius := 100.0

var dragging := false
var direction := Vector2.ZERO

func _ready():
	# Đặt joystick nhỏ vào giữa joystick lớn (vị trí gốc là top-left)
	base.position = (size - base.size) / 2.0

func _gui_input(event):
	if event is InputEventScreenTouch or event is InputEventMouseButton:
		if event.pressed:
			dragging = true
		else:
			dragging = false
			base.position = (size - base.size) / 2.0
			direction = Vector2.ZERO

func _process(delta):
	if dragging:
		var center := size / 2.0
		var local_pos := get_local_mouse_position() - center
		var clamped_pos := local_pos.limit_length(max_radius)
		
		# Đặt Base sao cho tâm của nó ở đúng chỗ chuột giới hạn
		base.position = clamped_pos + center - base.size / 2.0
		
		direction = clamped_pos.normalized()

func get_direction():
	return direction 
