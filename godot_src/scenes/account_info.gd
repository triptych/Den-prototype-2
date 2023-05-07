extends Control

var save_dict: Dictionary = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func setUsernameInput(value):
	print('setUsernameInput')
	print(value)
	$VBoxContainer/HBoxContainer/UsernameInput.text = value 
func _on_save_button_pressed():
	print('save button pressed')
	save()



func _on_load_button_pressed():
	print('load button pressed')
	loadData()
	pass # Replace with function body.
	


func _on_delete_button_pressed():
	print('delete button pressed')
	deleteData()
	pass # Replace with function body.
	
func save():
	save_dict = {
		"username": $VBoxContainer/HBoxContainer/UsernameInput.text
	}
	
	var save_game = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	var json_string = JSON.stringify(save_dict)
	save_game.store_line(json_string)
	
func loadData():
	if not FileAccess.file_exists("user://savegame.save"):
		return # Error! We don't have a save to load.
	
	var save_game = FileAccess.open("user://savegame.save", FileAccess.READ)
	while save_game.get_position() < save_game.get_length():
		var json_string = save_game.get_line()

		# Creates the helper class to interact with JSON
		var json = JSON.new()

		# Check if there is any error while parsing the JSON string, skip in case of failure
		var parse_result = json.parse(json_string)
		if not parse_result == OK:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			continue
		
		# Get the data from the JSON object
		var node_data = json.get_data()
		
		setUsernameInput(node_data["username"])

func deleteData():
	$VBoxContainer/HBoxContainer/UsernameInput.text = ""
