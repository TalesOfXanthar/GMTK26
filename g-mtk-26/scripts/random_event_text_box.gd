extends Control

@export var current_label : RichTextLabel
@export var choice_1 : Button
@export var choice_2 : Button
@export var choice_3 : Button

@export var timer : Timer
@export var text_speed := 0.05
var active_text_box : Control

var mouse_in_body := false

var encounter_identifier : String
var descriptions_left := 0

var text_path = "res://data_files/encounter_descriptions.json"
var text_json_string = FileAccess.get_file_as_string(text_path)
var text_dictionary = JSON.parse_string(text_json_string)

#These create and set a default for if the text box/option will be displayed.
var displayMainText = true
var diplayChoice1 = true
var diplayChoice2 = true
var diplayChoice3 = false

#This declares the variables and sets default text for all text options
var description_text = "You come across a stranded astronaut. For a second, the astronaut seems lifeless, before tapping your ships glass."
var question_text = "What will you do?"
var choice1Text = "dfgh"
var choice2Text = "sdfghj"
var choice3Text = ""

#Creates the prefix for text options. Either blank or the number key you can optionaly use to select
var mainTextPrefix = ""
var choice1Prefix = "1. "
var choice2Prefix = "2. "
var choice3Prefix = "3. "

##Basically sets up the entire text box system. Toggle calls visibility var, node is the node you want to effect, prefix is what will always come inline before the option, text is the text in richtext format, and keypress is the shortcut to select that option
func displayTextOption(toggle, node, prefix, text, keypress):
#Function to show or hide the text box and choices. The variable name sets the state and the node is what changes
	node.text = text + prefix
	
	#If choice is visible allow keyboard shortcut
	if toggle == true:
		node.show()
		if (Input.is_action_just_pressed(keypress)):
			node.pressed
	else:
		node.hide()

func change_all_text(main_label_text):
	#Calls function, see usage above
	displayTextOption(displayMainText, current_label, main_label_text, mainTextPrefix, "blank_input")
	displayTextOption(diplayChoice1, choice_1, choice1Text, choice1Prefix, "choice_1")
	displayTextOption(diplayChoice2, choice_2, choice2Text, choice2Prefix, "choice_2")
	#displayTextOption(diplayChoice3, choice_3, choice3Text, choice3Prefix, "choice_3")
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	random_identifier = GlobalData.random_identifier
	timer.timeout.connect(timer_timeout)
	change_all_text(description_text)
	reveal_text()


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

func shift_to_question():
	current_label = get_node("TabContainer/ScrollContainer/VBoxContainer/QuestionLabel")
	$TabContainer/ScrollContainer.visible = true
	change_all_text(question_text)
	reveal_text()

func shift_to_next_description():
	descriptions_left -= 1
	


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("mouse_left_click"):
		if current_label.visible_ratio == 1.0 && current_label != get_node("TabContainer/ScrollContainer/VBoxContainer/QuestionLabel"):
				if descriptions_left == 0:
					shift_to_question()
				else:
					shift_to_next_description()
		elif current_label.visible_ratio != 1.0:
			timer.stop()
			current_label.visible_ratio = 1.0


func _on_mouse_entered() -> void:
	mouse_in_body = true


func _on_mouse_exited() -> void:
	mouse_in_body = false
