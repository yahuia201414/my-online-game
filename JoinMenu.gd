extends Control

func _on_join_pressed():
	var password = $PasswordInput.text
	var host_ip = "192.168.1.5"  # ضع هنا IP جهاز الـ Host في الشبكة
	if password == "":
		print("Enter a password!")
		return
	NetworkManager.join_game(password, host_ip)


func _on_join_button_pressed():
	var password = $PasswordInput.text
	var host_ip = "192.168.1.5"  # ضع هنا IP جهاز الـ Host في الشبكة
	if password == "":
		print("Enter a password!")
		return
	NetworkManager.join_game(password, host_ip) # Replace with function body.
