extends Label

var score = 0

func increment():
	score += 1
	text = "Score: %s" % score
