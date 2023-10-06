extends CharacterBody2D

@onready var animated_srpite = $AnimatedSprite2D
@onready var animator = $AnimationPlayer
@export var speed = 7000
@export var JUMP_FORCE = -170
@export var gravityMultiplier = 1
@export var gravity = 0



# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _physics_process(delta):
	HandleMovement(delta)
	HandleJumps(delta)
	
	
	if position.y > 400:
		get_tree().reload_current_scene()
	move_and_slide()





func HandleMovement(delta):
	var dir = 0
	if velocity == Vector2.ZERO:
		animated_srpite.play("Idle")

	if Input.is_action_pressed("Duck"):
		animated_srpite.play("Duck")
		animator.play("duck")
	if Input.is_action_pressed("Move_Right"):
		dir = 1
		animated_srpite.flip_h = false
		
	if Input.is_action_pressed("Move_Left"):
		dir = -1
		animated_srpite.flip_h = true
	velocity.x = dir * speed * delta
	if dir != 0 and is_on_floor():
		animated_srpite.play("Run")


func HandleJumps(delta):
	if is_on_floor():
		gravityMultiplier = 1
	if not is_on_floor():
		velocity.y += gravity * delta * gravityMultiplier
	if Input.is_action_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_FORCE
		animated_srpite.play("Jump")
	if Input.is_action_just_released("Jump"):
		gravityMultiplier = 2

func _on_area_2d_body_entered(body):
	get_tree().reload_current_scene()

