extends Unit
class_name Player 
var move_dir: Vector2
func _ready() -> void:
	super._ready()
func _process(delta: float) -> void:
	move_dir = Input.get_vector("left","right","up","down")
	var current_velocity = move_dir*500
	position += current_velocity*delta
	position.x = clamp(position.x,-1000,1000)
	position.y = clamp(position.y,-500,500)
	update_animations()
	update_rotation()
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
