extends MarginContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$VBoxContainer/MenuButton.connect("pressed", self, "_on_menu_pressed")

func _on_menu_pressed():
	get_tree().change_scene("res://StartMenu.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
