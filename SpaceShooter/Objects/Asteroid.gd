extends RigidBody2D

#############
# VARIABLES #
#############

const SPEED = -200
onready var world = get_node("/root/World")
onready var hits = world.level

###########
# ON LOAD #
###########

func _ready():
	# add to asteroid group
	add_to_group("asteroids")
	
	# connect signals
	$VisibilityNotifier2D.connect("screen_exited", self, "_on_asteroid_exited")
	pass

###########
# SIGNALS #
###########

func _on_asteroid_exited():
	queue_free()
	pass

#############
# FUNCTIONS #
#############

# explode
func hit():
	if hits == 1:
		get_node("/root/World/UserInterface/ScoreLabel").increment()
		# Play explosion sound and remove the asteroid
		SoundManager.play("res://Sounds/Explosion.wav")
		#$SoundExplosion.play(0)
		queue_free()
	else:
		get_node("Hitpoints").decrement()
		SoundManager.play("res://Sounds/Explosion.wav")
		hits -= 1

########
# LOOP #
########

func _physics_process(delta):
	# Move in the -x direction by SPEED
	position += transform.x * SPEED * delta
	pass
