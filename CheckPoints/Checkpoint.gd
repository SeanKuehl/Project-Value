extends Area2D

onready var test = load("res://Weapons/Weapon.tscn")

func _ready():
	pass


func _on_Area2D_body_entered(body):
	if body.is_in_group("Enemy"):
		pass
		#do noting, enemies don't pick up weapons
	if body.is_in_group("Player"):
		#if it's the player, then perform a save
		#set "current" level as global(check points will probably take you to different scenes)
		
		get_tree().change_scene("res://Levels/LevelTwo.tscn")
		var thisLevel = get_tree().current_scene.filename
		Global.currentLevel = thisLevel
		
		
		
		
		
		
		#res://Levels/LevelTwo.tscn
		
		#change to next level, then set the current level and give player guns
		
		#maybe I'll have level changers just before checkpoints so 
		#you're always on the right level when you hit a checkpoint
		
		#a level changer and a checkpoint should be the same thing as you
		#wouldn't want to load a save, not hit the checkpoint and then the save regresses!

		#get_tree().change_scene("res://GameOver/GameOverScene.tscn")

func SaveGame():
	#here's the file reading stuff from the docs which is actually helpful
	#https://docs.godotengine.org/en/stable/classes/class_file.html
	var file = File.new()
	file.open("res://SaveFiles/SaveGame.tres", File.WRITE)
	file.store_string(Global.currentLevel)
	file.close()
	
