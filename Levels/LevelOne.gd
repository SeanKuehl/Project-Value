extends Node2D


onready var test = load("res://Weapons/Weapon.tscn")

func _ready():
	var player = get_tree().current_scene.get_node("Player")
	var gun = test.instance()
	gun.SetPickedUpValues(gun.GetAmmoInClip(), gun.GetAmmoInPool())
	player.EquipWeapon(gun)
	Global.currentPlayerHealth = player.GetHealth()
