extends CanvasLayer

signal fade_out_completed

var fade_in_rect : ColorRect
var fade_out_rect : ColorRect
var fade_timer : Timer

var fade_time := 1.0
var fade_in_active := false
var fade_out_active := false

func _ready() -> void:
	set_process(false)
	fade_timer = get_node("/root/SceneManager/FadeLayer/FadeTimer")
	fade_in_rect = get_node("/root/SceneManager/FadeLayer/FadeInRect")
	fade_out_rect = get_node("/root/SceneManager/FadeLayer/FadeOutRect")
	fade_timer.timeout.connect(fade_timeout)
	

func _process(_delta: float) -> void:
	if fade_in_active == true:
		var percent_completed = 1.0 - (fade_timer.time_left / fade_timer.wait_time)
		fade_in_rect.color = Color(0, 0, 0, 1.0 - percent_completed)
	if fade_out_active == true:
		var percent_completed = 1.0 - (fade_timer.time_left / fade_timer.wait_time)
		fade_out_rect.color = Color(0, 0, 0, percent_completed)

func fade_in():
	fade_in_rect.color = Color(0, 0, 0, 1)
	fade_in_rect.show()
	fade_timer.wait_time = fade_time
	fade_in_active = true
	set_process(true)
	fade_timer.start()

func fade_out():
	fade_out_rect.color = Color(0, 0, 0, 0)
	fade_out_rect.show()
	fade_timer.wait_time = fade_time
	fade_out_active = true
	set_process(true)
	fade_timer.start()

func fade_timeout():
	if fade_in_active == true:
		fade_in_active = false
		fade_in_rect.hide()
		set_process(false)
	if fade_out_active == true:
		fade_out_active = false
		fade_out_completed.emit()
		fade_out_rect.hide()


	
