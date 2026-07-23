extends Node
# This is a global variable, meaning that any script can access
# the variables and functions from this script.

# "user://" calls to the local save data of the computer the game's
# being run on, so save files are stored on the user side and
# don't save in github pushes. It's also easier to change stored
# info while the game is running if it's not inside the game itself.
var SAVE_PATH := "user://saved_information.tres"
# Makes it so this variable can only be an instance of the
# "SavedInformation" script, and sets it to nothing on startup.
var saved_information : SavedInformation = null


# Calls check_save on the game startup, so that if a new save
# needs to be made, it makes one, and the previously saved saves 
# are already loaded in.
func _ready() -> void:
	check_save()

## On call, calls to check if their is pre-existing save data, and
## is so, sets the saved_information variable to that data, and if
## not, creates a new instance of saved_information for that data.
func check_save() -> void:
	if ResourceLoader.exists(SAVE_PATH):
		saved_information = ResourceLoader.load(SAVE_PATH, "", ResourceLoader.CACHE_MODE_IGNORE)
	else:
		saved_information = SavedInformation.new()

## Saves the current instance of the saved_information variable
## and any changes to it into the user files, so we can load it
## later.
func save_info() -> void:
	ResourceSaver.save(saved_information, SAVE_PATH)
