extends CanvasLayer


onready var text = $Label
onready var secondLabel = $Label2
onready var healthLabel = $Label3

func _ready():
	pass

func _physics_process(delta):
	#if the weapon is the knife, display special stuff
	if Global.currentWeaponName == "Knife":
		text.text = "-- / --"
		secondLabel.text = Global.currentWeaponName
		
	else:
		text.text = String(Global.currentAmmoInClip) + " / " + String(Global.currentAmmoInPool)
		secondLabel.text = Global.currentWeaponName
		
	healthLabel.text = "Player Health: " + String(Global.currentPlayerHealth)
	
	
