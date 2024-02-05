extends ColorRect

var hue = 0.0  # Initial hue value
var lerp_speed = 0.1  # Adjust the speed of color transition

func _process(delta):
	# Update hue value
	hue += lerp_speed * delta
	if hue > 1.0:
		hue -= 1.0
	
	# Set the ColorRect color using HSV
	self.color = Color.from_hsv(hue, 1.0, 0.5, 0.5)
