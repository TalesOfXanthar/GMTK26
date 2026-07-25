extends Label

@export var countdown_timer : Timer

func _process(delta: float) -> void:
	var seconds_left = int(countdown_timer.time_left) % 60
	var minutes_left = int((countdown_timer.time_left - seconds_left) / 60)
	
	if seconds_left >= 10:
		text = str(minutes_left) + ":" + str(seconds_left)
	else:
		text = str(minutes_left) + ":0" + str(seconds_left)
	
	if minutes_left <= 5:
		add_theme_font_size_override("font_size", 20)
	if minutes_left <= 1:
		add_theme_color_override("font_color", Color(0.479, 0.0, 0.013, 1.0))
