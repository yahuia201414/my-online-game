extends Control

func _on_start_pressed():
	var password = $PasswordInput.text
	if password == "":
		print("Enter a password!")
		return
	NetworkManager.host_game(password)
	get_tree().change_scene_to_file("res://Scenes/Game.tscn")


func _on_start_button_pressed():
	var password = $PasswordInput.text
	if password == "":
		print("Enter a password!")
		return
	NetworkManager.host_game(password)
	get_tree().change_scene_to_file("res://Scenes/Game.tscn") # Replace with function body.
