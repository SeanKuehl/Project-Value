extends Control


func _ready():
	pass


func _on_Play_Again_pressed():
	get_tree().change_scene(Global.currentLevel)


func _on_Quit_pressed():
	get_tree().quit()
	
	

