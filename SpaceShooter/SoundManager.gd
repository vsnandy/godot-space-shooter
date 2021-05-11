# SoundManager.gd
# @description: Manages sound effects

extends Node

#############
# VARIABLES #
#############

const NUM_PLAYERS = 8
const BUS = "master"

var available = [] # Available players
var queue = [] # Queue of sounds

###########
# ON LOAD #
###########

# Called when the node enters the scene tree for the first time.
func _ready():
	# Play the background music
	var background = AudioStreamPlayer.new()
	add_child(background)
	background.set_volume_db(-20.0)
	background.set_autoplay(true)
	background.set_stream(load("res://Sounds/BackgroundMusic.wav"))
	background.play()
	
	# Create the AudioStreamPlayer nodes
	for i in NUM_PLAYERS:
		var p = AudioStreamPlayer.new() # instantiate audiostreamplayer
		add_child(p) # add it to the scene
		p.set_volume_db(-20.0)
		available.append(p) # add it to the available array
		p.connect("finished", self, "_on_stream_finished", [p]) # connect signal
		p.bus = BUS # set bus to master

###########
# SIGNALS #
###########

func _on_stream_finished(stream):
	# When finished playing a stream, make the player available again
	available.append(stream)

#############
# FUNCTIONS #
#############

func play(path):
	queue.append(path)

########
# LOOP #
########

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	# Play a queued sound if any players are available
	if not queue.empty() and not available.empty():
		available[0].stream = load(queue.pop_front())
		available[0].play()
		available.pop_front()
