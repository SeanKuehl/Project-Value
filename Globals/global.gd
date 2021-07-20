extends Node

var currentAmmoInClip = 0
var currentAmmoInPool = 0
var currentWeaponName = ""
var currentPlayerHealth = 0
var currentLevel = ""

var theKnife = load("res://Weapons/Knife.tscn")
var thePistol = load("res://Weapons/Weapon.tscn")

func _ready():
	pass
	
func GetEquippedGun():
	if Global.currentWeaponName == "Knife":
		return theKnife
	if Global.currentWeaponName == "Pistol":
		return thePistol
