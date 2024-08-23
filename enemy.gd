extends CharacterBody2D

const SPEED = 150.0
const JUMP_VELOCITY = -400.0
var health = 3
var looped = true

@onready var sprite = $AnimatedSprite2D
@onready var main = get_parent()
@onready var player = get_parent().get_node('player')
@onready var kills_counter = player.get_node('CanvasLayer/Interface/KillsCounter')


func _ready() -> void:
	animation_controller("apears")
	looped = false

func _physics_process(delta: float) -> void:
	if is_on_floor():
		if(velocity.x > 1 || velocity.x < -1):
			animation_controller("runing")
		else:
			animation_controller("idle")
			
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		if velocity.y > 0 and not is_on_floor():
			animation_controller("fall")
	
	var direction = global_position.direction_to(player.global_position)
	if direction and looped:
		velocity.x = direction.x * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()

	var isLeft = velocity.x < 0
	sprite.flip_h = isLeft

func animation_controller(animation: String):
	if(animation == "idle" and looped):
		sprite.animation = "idle"
	elif(animation == "runing" and looped):
		sprite.animation = "runing"
	elif(animation == "hit"):
		sprite.animation = "hit"
	elif(animation == "fall"):
		sprite.animation = "fall"
	elif(animation == "death"):
		sprite.animation = "death"
	elif(animation == "apears"):
		sprite.animation = "apears"	

func take_damange():
	health -= 1.5
	if health == 0:
		sprite.stop()
		animation_controller("death")
		sprite.play()
	elif  health > 0:
		if !looped:	
			sprite.stop()
			looped = false
			sprite.frame = 0
			sprite.play()
		else:
			sprite.stop()
			looped = false
			animation_controller("hit")
			sprite.play()


func _on_animated_sprite_2d_animation_looped() -> void:
	if health <= 0:
		var label = kills_counter.get_node('Label')
		main.enemy_quantity -= 1
		player.kills += 1
		label.set_text(str(player.kills))
		queue_free()
	if !looped:
		looped = true
	
