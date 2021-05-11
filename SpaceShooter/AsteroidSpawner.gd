######################
# AsteroidSpawner.gd #
######################

extends Node

#############
# VARIABLES #
#############

# Load the Asteroid object scene
var asteroid_scene = load("res://Objects/Asteroid.tscn")

###########
# ON LOAD #
###########

# Called when the node enters the scene tree for the first time.
func _ready():
	# connect signals
	$SpawnTimer.connect("timeout", self, "_on_timer_trigger") # timer signal
	
	pass

###########
# SIGNALS #
###########

# on timer interval
func _on_timer_trigger():
	spawn_asteroid()
	
#############
# FUNCTIONS #
#############

# spawn an asteroid
func spawn_asteroid():
	var asteroid = asteroid_scene.instance()
	set_asteroid_position(asteroid)
	add_child(asteroid)

# set an asteroid's position randomly using the viewport
func set_asteroid_position(asteroid):
	var rect = get_viewport().size
	asteroid.position = Vector2(1940, rand_range(64, rect.y))
	pass

########
# LOOP #
########

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
