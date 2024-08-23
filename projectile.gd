extends Area2D

const SPEED = 500
const RANGE = 1000
var traveled_distance = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * SPEED * delta
	
	traveled_distance += SPEED * delta
	if traveled_distance > RANGE:
		queue_free()


func _on_body_entered(body: Node2D) -> void:
	queue_free()
	if body.has_method("take_damange"):
		body.take_damange()
