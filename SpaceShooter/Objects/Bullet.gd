extends Area2D

#############
# VARIABLES #
#############

var speed = 750

###########
# ON LOAD #
###########

func _ready():
	# add this instance to the bullets group
	add_to_group("bullets")
	
	# connect signals
	$VisibilityNotifier2D.connect("screen_exited", self, "_on_bullet_exited")
	connect("body_entered", self, "_on_collision_detected")
	
	# play sound
	SoundManager.play("res://Sounds/Laser.wav")
	pass

###########
# SIGNALS #
###########

# Catch signal that bullet is off screen & remove the instance
func _on_bullet_exited():
	queue_free()
	pass
	
# Bullet hit something
func _on_collision_detected(area):
	if area.is_in_group("asteroids"):
		speed = 0 # set bullet speed to 0
		area.call_deferred("hit") # explode the asteroid
		$Sprite.play("Hit") # play the hit animation
		yield($Sprite, "animation_finished") # wait for animation to play
		queue_free() # remove the bullet
		
		# Random chance of power up
		if randi() % 10 == 0:
			if get_node("/root/World/Player").splitshot == false:
				get_node("/root/World/Player").enable_splitshot()
		
	pass

########
# LOOP #
########

func _process(delta):
	# due to rotation, use transform.y
	position += transform.y * speed * delta
	pass
