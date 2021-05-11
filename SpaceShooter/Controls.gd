extends MarginContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	$HBoxContainer/Back.connect("pressed", self, "_on_back_pressed")

# SIGNALS

func _on_back_pressed():
	get_tree().change_scene("res://StartMenu.tscn")
