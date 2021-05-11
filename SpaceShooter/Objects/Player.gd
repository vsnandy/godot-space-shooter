#############
# Player.gd #
#############

extends KinematicBody2D

#############
# VARIABLES #
#############

# load Bullet.tscn into var Bullet
var Bullet = preload("res://Objects/Bullet.tscn")

const SPEED = 400 # speed of the ship
const UP = Vector2.UP # upwards normal vector
const MAX_BULLETS = 5 # max # of bullets on screen at a time

var velocity = Vector2(0, 0) # velocity vector (unidirectional)
var lives = 3 # how many lives
var splitshot = false # splitshot power up, false to start

onready var pupbar = get_node("/root/World/UserInterface/PowerUpBar")
const MAX_VAL = 10.0

###########
# ON LOAD #
###########

func _ready():
	# connect signals
	$Hitbox.connect("body_entered", self, "_on_asteroid_hit")
	pupbar.visible = false
	pupbar.max_value = MAX_VAL
	pass

###########
# SIGNALS #
###########

# hit by asteroid, decrement lives
func _on_asteroid_hit(body):
	if body.is_in_group("asteroids"):
		# decrement lives & destroy the asteroid
		lives -= 1
		body.queue_free()
		
		if lives == 0:
			$Sprite.play("Explode")
			# Play explosion sound and remove the asteroid
			SoundManager.play("res://Sounds/Explosion.wav")
			yield($Sprite, "animation_finished")
			queue_free()
			get_tree().change_scene("res://GameOver.tscn")

# handle inputs
func _unhandled_key_input(event):
	if event.is_action_pressed("shoot"):
		shoot()

#############
# FUNCTIONS #
#############

# Enable splitshot
func enable_splitshot():
	print("splitshot enabled!")
	splitshot = true
	pupbar.visible = true
	var t = Timer.new()
	t.set_wait_time(MAX_VAL)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	while !t.is_stopped():
		pupbar.value = t.time_left
		yield(get_tree(), "physics_frame")
	splitshot = false
	pupbar.visible = false

# on SPACE press, shoot a bullet
func shoot():
	# check if bullets group is at max capacity
	#var all_bullets = get_tree().get_nodes_in_group("bullets")
	#if len(all_bullets) < MAX_BULLETS:
	# Instantiates the bullet & adds it to the World scene
	if not splitshot:
		var b = Bullet.instance()
		get_node("/root/World").add_child(b)
	
		# sets its position at the Position2D location
		b.global_position = $Position2D.global_position
	else:
		# Instantiate 3 bullets
		var b1 = Bullet.instance()
		var b2 = Bullet.instance()
		var b3 = Bullet.instance()
		
		get_node("/root/World").add_child(b1)
		get_node("/root/World").add_child(b2)
		get_node("/root/World").add_child(b3)
		
		b1.global_position = $Position2D.global_position + Vector2(0, 50)
		b2.global_position = $Position2D.global_position
		b3.global_position = $Position2D.global_position + Vector2(0, -50)

# Ship Controls
func ship_controls():
	if Input.is_action_pressed("ui_up"):
		# check if at top edge
		if not is_on_wall():
			velocity.y = -SPEED
			$Sprite.play("Up") # play up animation
	elif Input.is_action_pressed("ui_down"):
		# check if at bottom edge
		if not is_on_wall():
			velocity.y = SPEED
			$Sprite.play("Down")
	else:
		velocity.y = 0
		if lives > 1:
			$Sprite.play("Hover")
		elif lives == 1:
			$Sprite.play("Damaged")

########
# LOOP #
########

func _physics_process(_delta):
	# check for control
	ship_controls()
	
	# move the player by certain velocity and bounce if hitting a
	# collision object
	velocity = move_and_slide(velocity, UP)
	
	pass
