extends Node2D

var screen_size : Vector2i
var max_enemy_quantity : int = 5
var enemy_quantity : int = 0
@onready var player = $player
@onready var ground = %GorundLevel

func _ready() -> void:
	screen_size = get_window().size

func spawn_mob():
	var new_mob = preload("res://enemy.tscn").instantiate()
	
	var random_number = randi() % 10 + 1
	
	if  random_number <= 5:
		$Ground/Left_Path/PathFollow2D.progress_ratio = randf()
		new_mob.global_position = $Ground/Left_Path/PathFollow2D.global_position
		add_child(new_mob)
	else:
		$Ground/Rigth_Path/PathFollow2D.progress_ratio = randf()
		new_mob.global_position = $Ground/Rigth_Path/PathFollow2D.global_position
		add_child(new_mob)


func _on_timer_timeout() -> void:
	if enemy_quantity < max_enemy_quantity:
		enemy_quantity += 1
		spawn_mob()

func _on_left_map_end_body_entered(body: Node2D) -> void:
	$Left_barrier/CanvasLayer.visible = true

func _on_rigth_map_end_body_entered(body: Node2D) -> void:
	$Rigth_barrier/CanvasLayer.visible = true

func _on_left_map_end_body_exited(body: Node2D) -> void:
	$Left_barrier/CanvasLayer.visible = false

func _on_rigth_map_end_body_exited(body: Node2D) -> void:
	$Rigth_barrier/CanvasLayer.visible = false
