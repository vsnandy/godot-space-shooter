extends Label


# Declare member variables here. Examples:
onready var vars = get_node("/root/GlobalVariables")


# Called when the node enters the scene tree for the first time.
func _ready():
	text = "(Level %s)" % String(vars.level)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	text = "(Level %s)" % String(vars.level)
