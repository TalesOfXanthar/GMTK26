extends VBoxContainer

#These create and set a default for if the text box/option will be displayed.
var displayMainText = true
var diplayChoice1 = true
var diplayChoice2 = true
var diplayChoice3 = false

#This declares the variables and sets default text for all text options
var mainTextContent = "blah blah "
var choice1Text = "dfgh"
var choice2Text = "sdfghj"
var choice3Text = ""

#Creates the prefix for text options. Either blank or the number key you can optionaly use to select
var mainTextPrefix = ""
var choice1Prefix = "1. "
var choice2Prefix = "2. "
var choice3Prefix = "3. "

#Basically sets up the entire text box system. Toggle calls visibility var, node is the node you want to effect, prefix is what will always come inline before the option, text is the text in richtext format, and keypress is the shortcut to select that option
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
	 
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#Calls function, see usage above
	displayTextOption(displayMainText, $mainText, mainTextContent, mainTextPrefix, "blank_input")
	displayTextOption(diplayChoice1, $Choice_1, choice1Text, choice1Prefix, "choice_1")
	displayTextOption(diplayChoice2, $Choice_2, choice2Text, choice2Prefix, "choice_2")
	displayTextOption(diplayChoice3, $Choice_3, choice3Text, choice3Prefix, "choice_3")
	
