extends Control

signal end_dialogue

@export var current_label : RichTextLabel
@export var choice_1 : Button
@export var choice_2 : Button
@export var choice_3 : Button

@export var timer : Timer
@export var text_speed := 0.05
var active_text_box : Control

var mouse_in_body := false

var end_result := false

var encounter_id : String
var descriptions_left := 0

var text_path = "res://data/encounter_descriptions.json"
var text_json_string = FileAccess.get_file_as_string(text_path)
var text_dictionary : Dictionary = JSON.parse_string(text_json_string)

#This declares the variables and sets default text for all text options
var current_text = "You come across a stranded astronaut. For a second, the astronaut seems lifeless, before tapping your ships glass."
var choice1Text = "dfgh"
var choice2Text = "sdfghj"
var choice3Text = ""

#Creates the prefix for text options. Either blank or the number key you can optionaly use to select
var mainTextPrefix = ""
var choice1Prefix = "1. "
var choice2Prefix = "2. "
var choice3Prefix = "3. "

var choice_2_visible := false
var choice_3_visible := false

##Basically sets up the entire text box system. Toggle calls visibility var, node is the node you want to effect, prefix is what will always come inline before the option, text is the text in richtext format, and keypress is the shortcut to select that option
func displayTextOption(node, prefix, text, keypress):
#Function to show or hide the text box and choices. The variable name sets the state and the node is what changes
	node.text = text + prefix
	
	#If choice is visible allow keyboard shortcut
		#if (Input.is_action_just_pressed(keypress)):
			#node.pressed
	#else:
		#node.hide()

func change_all_text():
	#Calls function, see usage above
	var choices_list : Array = text_dictionary[encounter_id]["choices"].keys()
	
	displayTextOption(current_label, current_text, mainTextPrefix, "blank_input")
	displayTextOption(choice_1, choices_list[0], choice1Prefix, "choice_1")
	if choices_list.size() >= 1:
		choice_2_visible = true
		displayTextOption(choice_2, choices_list[1], choice2Prefix, "choice_2")
		if choices_list.size() >= 2:
			choice_3_visible = true
			displayTextOption(choice_3, choices_list[2], choice3Prefix, "choice_3")
		else:
			choice_2_visible = false
	else:
		choice_2_visible = false
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.timeout.connect(timer_timeout)
	choice_1.pressed.connect(choice_selected.bind(1))
	choice_2.pressed.connect(choice_selected.bind(2))
	choice_3.pressed.connect(choice_selected.bind(3))
	
	encounter_id = GlobalData.encounter_identifier
	#Subtract one here because you are immidietly instating a description.
	descriptions_left = text_dictionary[encounter_id]["descriptions"].size()
	
	shift_to_next_description()


func reveal_text():
	current_label.visible_ratio = 0
	timer.wait_time = text_speed
	timer.start()

func timer_timeout():
	var char_number = current_label.get_total_character_count()
	var char_percent : float = (1.0 / char_number)
	current_label.visible_ratio += char_percent
	if current_label.visible_ratio >= 1.0:
		timer.stop()
		if current_label == get_node("TabContainer/ScrollContainer/VBoxContainer/QuestionLabel"):
			choice_1.show()
			choice_2.visible = choice_2_visible
			choice_3.visible = choice_3_visible

func shift_to_question():
	current_label = get_node("TabContainer/ScrollContainer/VBoxContainer/QuestionLabel")
	current_text = text_dictionary[encounter_id]["question"]
	$TabContainer/ScrollContainer.show()
	change_all_text()
	reveal_text()

func shift_to_next_description():
	descriptions_left -= 1
	var array_id = (descriptions_left * -1) - 1
	current_text = text_dictionary[encounter_id]["descriptions"][array_id]
	change_all_text()
	reveal_text()
	
	


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("mouse_left_click"):
		if current_label.visible_ratio == 1.0 && current_label != get_node("TabContainer/ScrollContainer/VBoxContainer/QuestionLabel"):
				if descriptions_left == 0:
					if end_result == false:
						shift_to_question()
					else:
						end_dialogue.emit()
				else:
					shift_to_next_description()
		elif current_label.visible_ratio != 1.0:
			timer.stop()
			current_label.visible_ratio = 1.0
			if current_label == get_node("TabContainer/ScrollContainer/VBoxContainer/QuestionLabel"):
				choice_1.show()
				choice_2.visible = choice_2_visible
				choice_3.visible = choice_3_visible	

func _on_mouse_entered() -> void:
	mouse_in_body = true

func _on_mouse_exited() -> void:
	mouse_in_body = false
	
func choice_selected(choice_number):
	end_result = true
	current_label = get_node("TabContainer/DescriptionLabel")
	var selected_choice_key = text_dictionary[encounter_id]["choices"].keys()[choice_number - 1]
	var selected_choice_dict = text_dictionary[encounter_id]["choices"][selected_choice_key]
	var outcome_text = random_chance_calc(selected_choice_dict)
	current_text = outcome_text
	current_label.show()
	change_all_text()
	reveal_text()

func random_chance_calc(choice_dict : Dictionary):
	var chance_array := []
	for value in choice_dict.keys():
		chance_array.append(float(value) * randf())
	
	var outcome_key = choice_dict.keys()[chance_array.find(chance_array.max())]
	
	var outcome_event = choice_dict[outcome_key][1]
	
	
	var outcome_text = choice_dict[outcome_key][0]
	return outcome_text
	
	
	
