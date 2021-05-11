extends RichTextLabel


# Declare member variables here. Examples:
onready var vars = get_node("/root/GlobalVariables")
onready var hits = vars.level

# Called when the node enters the scene tree for the first time.
func _ready():
	bbcode_text = "[center]%s[/center]" % String(hits)

func decrement():
	hits -= 1

func _process(delta):
	bbcode_text = "[center]%s[/center]" % String(hits)
