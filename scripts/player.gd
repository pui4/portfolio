extends CharacterBody3D

var lookSpeed = 0.1
var p_speed = 10
var d_speed = 1000
var glide = 5
var a_glide = 1
var n_glide = 6
var gravity = 30
var jump = 10

var direction = Vector3()
var glide_v = Vector3()
var movement = Vector3()
var grav_v = Vector3()

var full_c = false

@onready var g_check = $"GroundCheck"

func _physics_process(delta):
	# Movement
	direction = Vector3()
	
	# Jumping
	if g_check.is_colliding():
		full_c = true
	else:
		full_c = false
	
	if not is_on_floor():
		grav_v += Vector3.DOWN * gravity * delta
		glide = a_glide
	elif is_on_floor() and full_c:
		grav_v = -get_floor_normal() * gravity
		glide = n_glide
	else:
		grav_v = -get_floor_normal()
		glide = n_glide
	
	if Input.is_action_just_pressed("jump") and (is_on_floor() or g_check.is_colliding()):
		grav_v = Vector3.UP * jump
	
	# Walking
	if Input.is_action_pressed("move_f"):
		direction -= transform.basis.z
	elif Input.is_action_pressed("move_b"):
		direction += transform.basis.z
	
	if Input.is_action_pressed("move_l"):
		direction -= transform.basis.x
	elif Input.is_action_pressed("move_r"):
		direction += transform.basis.x
	
	direction = direction.normalized()
	glide_v = glide_v.lerp(direction * p_speed, glide * delta)
	movement.z = glide_v.z + grav_v.z
	movement.x = glide_v.x + grav_v.x
	movement.y = grav_v.y
	
	velocity = movement
	move_and_slide()


func _on_jump_pressed():
	Input.action_press("jump", 1)
