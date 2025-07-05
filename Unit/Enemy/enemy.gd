extends Unit 
class_name Enemy

@export var flock_push := 20.0
var knockback_dir : Vector2
var knockback_power : float 
@onready var visions = $VisionArea
@onready var knock_time = $KnockbackTimer
var can_move := true
func _process(delta: float) -> void:
	if Global.game_paused : return
	if not can_move :
		return
	if not can_move_toward_player():
		return
	position += (get_move_direction()+knockback_dir*knockback_power) * stats.speed * delta
	update_rotation()
func get_move_direction() -> Vector2:
	if not is_instance_valid(Global.player):
		return Vector2.ZERO
	var direction := global_position.direction_to(Global.player.global_position)
	for area: Node2D in visions.get_overlapping_areas():
		if area != self and area.is_inside_tree():
			var vector := global_position - area.global_position
			direction+=flock_push*vector.normalized() / vector.length()
	return direction
func can_move_toward_player() -> bool:
	return is_instance_valid(Global.player) and global_position.distance_to(Global.player.global_position) > 60
func update_rotation():
	if not is_instance_valid(Global.player):
		return
	var player_pos := Global.player.global_position
	var moving_right := global_position.x < player_pos.x
	visuals.scale = Vector2(-0.5,0.5) if moving_right else Vector2(0.5,0.5)
func apply_knockback(knock_dir : Vector2,knock_power: float) :
	knockback_dir = knock_dir
	knockback_power = knock_power
	
	if knock_time.time_left > 0:
		
		knock_time.stop()
		reset_knockback()
	knock_time.start()
func reset_knockback():
	knockback_dir = Vector2.ZERO
	knockback_power =0.0
func destroy_enemy():
	can_move = false
	anm.play("die")
	await anm.animation_finished
	queue_free()

func _on_knockback_timer_timeout() -> void:
	reset_knockback()
func _on_hurt_box_component_on_damaged(hitbox: HitboxComponent) -> void:
	super._on_hurt_box_component_on_damaged(hitbox)
	if hitbox.knockback_power > 0:
		var dir:= hitbox.source.global_position.direction_to(global_position)
		apply_knockback(dir,hitbox.knockback_power)
