extends Node2D

onready var test = load("res://Weapons/Weapon.tscn")


#this works! now all I have to do is make a function to determine what weapon 
#to give them based on the weapon name and use it, maybe make the function in checkpoint
func _ready():
	var player = get_tree().current_scene.get_node("Player")
	var gun = test.instance()
	gun.SetPickedUpValues(Global.currentAmmoInClip, Global.currentAmmoInPool)
	player.EquipWeapon(gun)
	player.SetHealth(Global.currentPlayerHealth)
