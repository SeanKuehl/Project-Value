extends KinematicBody2D


var bullet = load("res://Bullets/Bullet.tscn")
var droppedVersion = load("res://DroppedWeapons/DroppedWeapon.tscn")	#this must be nothing for now to avoid a cyclic reference, see Drop() for where it's actually put	
var displayName = "testing pistol"
var ammoInClip = 5	#this is how much ammo the weapon can shoot before it has to reload
var ammoInPool = 25	#this is how much ammo the weapon can shoot before you run out of ammo
var maxAmmoInClip = 5
onready var coolDown = $AttackCooldown
onready var reloadCoolDown = $ReloadCooldown
onready var shootSound = $ShootSound
onready var reloadSound = $ReloadSound
onready var gunMuzzle = $Muzzle
#before I move on from just making classes, hook up current player gun to ui
var playerHandOffset = -5	#the middle of the gun is placed at the player's "gun point" on the hand which might
#not work for all guns, hence an offset will be used

#var damage, etc.
#.instance(), after setting it's position to muzzle

#add reloading, sounds for things, and dropping weapons.
#player always has a pistol by default, make bullets have damage


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func GetPlayerHandOffset():
	return playerHandOffset

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
#make a different area2d object for when the gun is dropped on the ground

#func Sample():
	#print("works")
	
func Reload():
	if ammoInPool > 0 and reloadCoolDown.is_stopped() and ammoInClip != maxAmmoInClip:
		ammoInPool += ammoInClip	#this is so the ammo left in the clip, if there is any is not wasted or lost
		ammoInClip = 0
		
		if ammoInPool >= maxAmmoInClip:
			ammoInPool -= maxAmmoInClip
			ammoInClip += maxAmmoInClip
			reloadSound.play()
			
			reloadCoolDown.start()
			#print(ammoInClip, ammoInPool)
		else:
			ammoInClip += ammoInPool
			ammoInPool = 0
			reloadSound.play()
			
			reloadCoolDown.start()
			#print(ammoInClip, ammoInPool)
			
			#there's not enough to reload a full mag, just reload as much as possible
	
func Shoot():
	if ammoInClip > 0 and coolDown.is_stopped():
		shootSound.play()
		
		var newBullet = bullet.instance()
		newBullet.transform = gunMuzzle.global_transform
		get_tree().current_scene.add_child(newBullet)
		#owner.add_child(newBullet)	#this will add the bullet to the owner of the player, which is the scene
		coolDown.start()
		ammoInClip -= 1
		#print(ammoInClip, ammoInPool)
		
		
func Drop():
	
	var dropped = droppedVersion.instance()
	dropped.transform = gunMuzzle.global_transform	#drop at the muzzle so it drops visibly in front of the player
	#droppedWeapon.position = weaponDropPos.position
	get_tree().current_scene.add_child(dropped)
	queue_free()
