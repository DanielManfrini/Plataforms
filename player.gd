extends CharacterBody2D

const SPEED: float = 300.0
const JUMP_VELOCITY: float = -400.0
var CAN_DOUBLE_JUMP: bool = false
@onready var sprite = $AnimatedSprite2D
@onready var IdleColision = $IdleColision
@onready var hearts = %Hearts

var lives: int = 3
var kills: int = 0

var initial_position: Vector2 = Vector2()

func _ready() -> void:
	initial_position = position

func _physics_process(delta: float) -> void:
	#animations
	if is_on_floor():
		if(velocity.x > 1 || velocity.x < -1):
			sprite.animation = "walking"
		else:
			sprite.animation = "idle"
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		if velocity.y > 0 and not is_on_floor():
			sprite.animation = "fall"

	# Handle jump.
	if Input.is_action_just_pressed("moveUp"):
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
			CAN_DOUBLE_JUMP = true
			sprite.animation = "jump"
		elif CAN_DOUBLE_JUMP:
			velocity.y = JUMP_VELOCITY
			sprite.animation = "double_jump"
			CAN_DOUBLE_JUMP = false


	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	var isLeft = velocity.x < 0
	sprite.flip_h = isLeft
	
func take_damange():
	var direction := Input.get_axis("ui_left", "ui_right")
	
	if(lives > 0):
		
		lives -= 1
		
		velocity.x = -direction * SPEED
		velocity.y = JUMP_VELOCITY
		sprite.animation = "hit"
		
		if(lives == 2):
			hearts.animation = "2lives"
		elif(lives == 1):
			hearts.animation = "1lives"
		elif(lives == 0):
			hearts.animation = "0lives"
			get_tree().reload_current_scene()
	
