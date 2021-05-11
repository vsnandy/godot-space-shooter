extends Label

# Declare member variables here. Examples:
onready var vars = get_node("/root/GlobalVariables")
var scoreColor = Color(0, 255, 0, 255)

# Called when the node enters the scene tree for the first time.
func _ready():
	text = "You scored %s points!" % String(vars.score)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	text = "You scored %s points!" % String(vars.score)
