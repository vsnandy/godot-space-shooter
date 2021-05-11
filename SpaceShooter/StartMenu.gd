extends MarginContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	# Play background music
	# Connect signals
	$VBoxContainer/StartGame.connect("pressed", self, "_on_start_pressed")
	$VBoxContainer/Controls.connect("pressed", self, "_on_controls_pressed")
	$VBoxContainer/About.connect("pressed", self, "_on_about_pressed")
	
# SIGNALS
func _on_start_pressed():
	get_tree().change_scene("res://World.tscn")

func _on_controls_pressed():
	get_tree().change_scene("res://Controls.tscn")

func _on_about_pressed():
	get_tree().change_scene("res://About.tscn")
