extends Area2D

@onready var enemy = get_parent()

func _physics_process(delta: float) -> void:
	look_at(enemy.player.global_position)
	
func shot():
	const PROJECTLE = preload("res://enemy_projectile.tscn")
	var new_bullet = PROJECTLE.instantiate()
	
	new_bullet.global_position = %RedStaffShotingPoint.global_position
	new_bullet.global_rotation = %RedStaffShotingPoint.global_rotation
	
	%RedStaffShotingPoint.add_child(new_bullet)


func _on_shoot_timer_timeout() -> void:
	shot()
	
