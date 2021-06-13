extends KinematicBody2D

#export (PackedScene) var Bullet
#var Bullet = preload("res://Bullets/Bullet.tscn").instance()

var speed = 400  # speed in pixels/sec

var velocity = Vector2.ZERO

var playerHealth = 100

onready var playerSprite = $soldier1_single_hand
onready var blinkTimer = $BlinkTimer

var playerWeapon = 0
var playerWantsToPickupWeapon = false
var defaultWeapon = load("res://Weapons/Knife.tscn")
var defaultWeaponEquipped = true

func _ready():
	#if I wanted to give player a weapon from the start I could set
	#defaultweaponequipped to false and put the pistol or something below
	EquipWeapon(defaultWeapon.instance())
	#example = preload("res://Weapons/Weapon.tscn").instance()
	
	#example.global_position.x - example.GetPlayerHandOffset() = $GunPosition.position
	#example.global_position = $GunPosition.position
	#example.global_position.x = example.global_position.x - example.GetPlayerHandOffset()
	#this works! adjust after setting it to the position works!
	#add_child(example)
	
	#w = preload("res://Weapon.tscn").instance()
	#w.global_position = $PlayerMuzzle.position
	#add_child(w)	#we want it to be a child of the player so it moves with the player
	#when you want to shoot etc, just call w.shoot() or other things
	#the code from the example might be helpful here

#body.is_in_group("Player")

func EquipWeapon(weapon):
	weapon.global_position = $GunPosition.position
	weapon.global_position.x = weapon.global_position.x - weapon.GetPlayerHandOffset()
	#this works! adjust after setting it to the position works!
	playerWeapon = weapon
	add_child(weapon)
	#print("this worked!")

func Reload():
	
	playerWeapon.Reload()

func Shoot():
	
	playerWeapon.Shoot() #call the weapon's shoot to handle the shooting etc
	#I will still want a generic weapon class to handle everything
	
	#var b = preload("res://PlayerBullet.tscn").instance() 	#make a new kind of bullet for enemy
	
	
	
	#owner.add_child(b)	#this adds the bullet as a child of the node that owns player, in this case the root node
	
	#i've looked up lots of fixes but none of them seem to work!
	#b.transform = $PlayerMuzzle.global_transform	#this will spawn the bullet at the point Muzzle found on the player

func PlayerPickupWeapon(weapon):
	if playerWantsToPickupWeapon:
		if defaultWeaponEquipped == true:
			defaultWeaponEquipped = false
			#unequip the default weapon
			UnequipDefault(playerWeapon)
		EquipWeapon(weapon)
		return true
	else:
		return false
		#don't pickup weapon

func I_Got_Hit(damage):
	playerHealth -= damage
	if playerHealth <= 0:
		pass
		#do death, go to game over screen
	else:
		
		#do damage
	#set_modulate(Color(0,1,0))
		playerSprite.set_modulate(Color(59,2,2))
		blinkTimer.start()
	

func get_input():
	#if is_in_group("Player"):
	#	pass
	#else:
	#	add_to_group("Player")
	
	#enemy will decide where to move at random
	velocity = Vector2.ZERO
	if Input.is_action_pressed('RIGHT'):
		velocity.x += 1
	if Input.is_action_pressed('LEFT'):
		velocity.x -= 1
	if Input.is_action_pressed('DOWN'):
		velocity.y += 1
	if Input.is_action_pressed('UP'):
		velocity.y -= 1
	if Input.is_action_just_pressed("SHOOT"):
		Shoot()
	if Input.is_action_just_pressed("RELOAD"):
		Reload()
	if Input.is_action_just_pressed("PICKUP"):
		playerWantsToPickupWeapon = true
	if Input.is_action_just_released("PICKUP"):
		playerWantsToPickupWeapon = false
	if Input.is_action_just_pressed("DROP"):
		if defaultWeaponEquipped == true:
			pass
		else:
			defaultWeaponEquipped = true
			playerWeapon.Drop()
			EquipWeapon(defaultWeapon.instance())
		
		#put in backup plan here so player is never defensless
		#add the backup plan weapon to player
		
	# Make sure diagonal movement isn't faster
	
	#I will need to add a reload, pickup and drop weapon actions/buttons

	velocity = velocity.normalized() * speed

func UnequipDefault(weapon):
	weapon.queue_free()

func _physics_process(delta):
	if blinkTimer.is_stopped():
		playerSprite.set_modulate(Color(1,1,1,1))
	
	look_at(get_global_mouse_position())
	get_input()
	velocity = move_and_slide(velocity)
