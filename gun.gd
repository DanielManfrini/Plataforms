extends Area2D

var energy: int = 10
@onready var energy_counter = %EnergyCounter
@onready var label = energy_counter.get_node('Label')

func _ready() -> void:
	label.set_text(str(energy))

func _physics_process(delta: float) -> void:
	look_at(get_global_mouse_position())
	label.set_text(str(energy))
	
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed and energy > 0:
			energy -= 1
			shot()

func shot():
	const PROJECTLE = preload("res://projectile.tscn")
	var new_bullet = PROJECTLE.instantiate()
	
	new_bullet.global_position = %ShotingPoint.global_position
	new_bullet.global_rotation = %ShotingPoint.global_rotation
	
	%ShotingPoint.add_child(new_bullet)

func _on_timer_timeout() -> void:
	if energy <10:
		energy += 1
