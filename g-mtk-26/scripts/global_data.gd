extends Node

signal event_triggered(event_type)

signal fade_out_completed

var input_movement_monitoring := true

var encounter_identifier : String

var fade_in_rect : ColorRect
var fade_out_rect : ColorRect
var timer : Timer
var fade_time := 1.0
var fade_in_active := false
var fade_out_active := false

func _ready() -> void:
	set_process(false)
	

func _process(delta: float) -> void:
	if fade_in_active == true:	
		var percent_completed = 1.0 - (timer.time_left / timer.wait_time)
		fade_in_rect.color = Color(0, 0, 0, 1 - percent_completed)
	if fade_out_active == true:	
		var percent_completed = 1.0 - (timer.time_left / timer.wait_time)
		fade_out_rect.color = Color(0, 0, 0, percent_completed)
	
	

func fade_timeout():
	if fade_in_active == true:
		fade_in_active = false
		set_process(false)
		fade_in_rect.hide()
	if fade_out_active == true:
		fade_out_active = false
		fade_out_completed.emit()
		set_process(false)
		fade_out_rect.hide()
		fade_in()
		

func fade_in():
	fade_in_rect = get_node("/root/SceneManager/SpaceScene/FadeLayer/FadeInRect")
	fade_in_rect.color = Color(0, 0, 0, 1)
	fade_in_rect.show()
	timer = get_node("/root/SceneManager/SpaceScene/FadeLayer/Timer")
	timer.timeout.connect(fade_timeout)
	timer.wait_time = fade_time
	fade_in_active = true
	set_process(true)
	timer.start()

func fade_out():
	fade_out_rect = get_node("/root/SceneManager/SpaceScene/FadeLayer/FadeOutRect")
	fade_out_rect.color = Color(0, 0, 0, 0)
	fade_out_rect.show()
	timer = get_node("/root/SceneManager/SpaceScene/FadeLayer/Timer")
	timer.timeout.connect(fade_timeout)
	timer.wait_time = fade_time
	fade_out_active = true
	set_process(true)
	timer.start()
	
	
