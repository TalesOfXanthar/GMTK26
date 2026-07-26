extends Label

@export var countdown_timer : Timer

@export var interaction_scene : PackedScene
@export var gui_canvas_layer : CanvasLayer
@export var stops : Stops


func _ready() -> void:
	GlobalData.stop_countdown.connect(timer_pause_unpause.bind(true))
	GlobalData.start_countdown.connect(timer_pause_unpause.bind(false))
	countdown_timer.timeout.connect(end_game)
	$AudioStreamPlayer.play()
	print("start")


func end_game():
	GlobalData.input_movement_monitoring = false
	GlobalData.fade_out()
	GlobalData.encounter_identifier = "supernova"
	GlobalData.fade_out_completed.connect(start_end_interaction)

func start_end_interaction():
	GlobalData.fade_out_completed.disconnect(start_end_interaction)
	stops.stop_id = "supernova"
	stops.start_interaction()

func timer_pause_unpause(state):
	countdown_timer.paused = state

func _process(delta: float) -> void:
	var seconds_left = int(countdown_timer.time_left) % 60
	var minutes_left = int((countdown_timer.time_left - seconds_left) / 60)
	
	if seconds_left >= 10:
		text = str(minutes_left) + ":" + str(seconds_left)
	else:
		text = str(minutes_left) + ":0" + str(seconds_left)
	
	if minutes_left == 0 and seconds_left == 60:
		$AudioStreamPlayer.stop()
		$Starchild.play()
	else:
		pass 
	#if minutes_left <= 5:
	#	add_theme_font_size_override("font_size", 20)
	if minutes_left <= 0:
		add_theme_color_override("font_color", Color(0.479, 0.0, 0.013, 1.0))
