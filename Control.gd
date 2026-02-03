extends Control

func _on_HostButton_pressed():
	get_tree().change_scene_to_file("res://Scenes/HostMenu.tscn")

func _on_JoinButton_pressed():
	get_tree().change_scene_to_file("res://Scenes/JoinMenu.tscn")


func _on_host_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/HostMenu.tscn") # Replace with function body.


func _on_join_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/JoinMenu.tscn") # Replace with function body.
