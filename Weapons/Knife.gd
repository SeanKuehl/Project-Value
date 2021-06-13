extends "res://Weapons/Weapon.gd"



#I don't have to worry about ammo or dropped version
#because this weapon doesn't consume ammo and can't be dropped



#only when the player drops all of their other weapons will they take out the knife
#they cannot drop the knife, this is the last resort weapon so that if the player
#made mistakes and no longer has a gun they can still kind of defend themselves

func _ready():
	displayName = "Knife"
	playerHandOffset = -5
	bullet = load("res://Bullets/KnifeBullet.tscn")
	
	coolDown = $AttackCooldown
	reloadCoolDown = $ReloadCooldown
	shootSound = $ShootSound
	reloadSound = $ReloadSound
	gunMuzzle = $Muzzle
	
#this overrides the base class Shoot because a Knife doesn't have ammo the way a regular gun does
func Shoot():
	#apparently if I'm overriding a function I put this as the last line of my function:
	#.Shoot() etc.
	
	#this is a knife, I don't need to worry about ammo, just the attack cooldown
	if coolDown.is_stopped():
		shootSound.play()
		
		var newBullet = bullet.instance()
		newBullet.transform = gunMuzzle.global_transform
		get_tree().current_scene.add_child(newBullet)
		
		coolDown.start()
		
		
	
	.Shoot()

#this overrides the base class reload because if a knife doesn't have ammo, there's nothing to reload
func Reload():
	#do nothing, there's no ammo to manipulate so don't play any sound effects or anything,
	#this function is only here in case they press reload while using the knife
	.Reload()

