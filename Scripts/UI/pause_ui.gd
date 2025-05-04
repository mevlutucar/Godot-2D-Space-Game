extends Control

@onready var main = $"../../../"

func _on_resume_button_pressed():
	main.pause_menu_operations()


func _on_restart_button_pressed():
	pass # Replace with function body.
