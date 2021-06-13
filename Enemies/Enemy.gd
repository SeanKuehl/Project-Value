extends KinematicBody2D


var health = 20
var speed = 50
var chaseSpeed = 200
var velocity = Vector2()

#var shootTimer = 0

var playerDetected = false
var IGotShot = false	#this will make enemy alert if they get shot

var minimap_icon = "mob"

onready var player = get_node('../Player') #this is based on what the player is called in the scene tree, not it's actual scene
onready var enemySprite = $manBlue_gun
onready var blinkTimer = $HurtBlinkTimer
onready var weaponDropPos = $DropWeaponSpot
onready var muzzle = $GunMuzzle
onready var shootTimer = $ShootRateTimer
onready var weaponToDropUponDeath = preload("res://DroppedWeapons/DroppedWeapon.tscn")
onready var bulletToShoot = preload("res://Bullets/Bullet.tscn")
var distanceToPlayer = 0
var spotPlayerDistance = 200	#this is the distance at which the player is spotted



var usingSimpleAI = true	#if using simpleAI rotation will happen, if rotation is set it will effect all other AI movement

#I will hard code what bullets/guns the enemies use so that I can customize it
#to the enemy without having to also balance things for the player
#maybe have enemy bullets but not enemy weapons

func _ready():
	if usingSimpleAI:
		rotation = rand_range(0, 2*PI)
	else:
		pass
	
	
	
	
#I'll also need some kind of die function
func I_Got_Hit(damage):
	health -= damage
	if health <= 0:
		var droppedWeapon = weaponToDropUponDeath.instance()
		droppedWeapon.transform = weaponDropPos.global_transform
		#droppedWeapon.position = weaponDropPos.position
		get_tree().current_scene.add_child(droppedWeapon)
		queue_free()
		#do death, they have to at least drop their gun
	else:
		IGotShot = true
		#do damage
	#set_modulate(Color(0,1,0))
		enemySprite.set_modulate(Color(59,2,2))
		blinkTimer.start()
	
	#something that shows that we got hit
	
	

func DistanceToPlayer(positionA, positionB):
	#position A is the player(x2) while position B is this(x1)
	#root of: (x2 - x1)^2 + (y2-y1)^2
	var xPart = pow((positionA.x - positionB.x),2.0)
	var yPart = pow((positionA.y - positionB.y),2.0)
	var total = abs((pow((xPart + yPart),0.5)) - 84)	#this is because the positions don't account for sprite size, I want the smallest distance to be 0 or close just for ease
	#note: this results in sometimes having a negative distance if too close, hence the abs, but the negative distances are still small and accurate enough
	return total


func shoot():
	
	
	
	var b = bulletToShoot.instance() 	#make a new kind of bullet for enemy
	
	b.transform = muzzle.global_transform
	get_tree().current_scene.add_child(b)
	shootTimer.start()
	
	
	#owner.add_child(b)	#this adds the bullet as a child of the node that owns player, in this case the root node
	
	#i've looked up lots of fixes but none of them seem to work!
	#b.transform = $EnemyMuzzle.global_transform	#this will spawn the bullet at the point Muzzle found on the player

func UpAndDownPatrollingAI(delta):
	
	#like the simple AI, but instead of walking around randomly,
	#they walk up and down(like in a halway/patrolling) until they either see the player
	#or are shot
	
	
	
	
	velocity = transform.x * speed	#this is fine unless it spots the player
	distanceToPlayer = DistanceToPlayer(player.position, position)
	#print(distanceToPlayer)
	#replace with upon detection
	
	
	if distanceToPlayer <= spotPlayerDistance or IGotShot == true:
		playerDetected = true
		
	else:
		playerDetected = false
	
	
	#make function that does below:(remember what an exponent really is for ^1/2)
	
	if playerDetected:
		#go towards the player
		look_at(player.position)
		velocity = transform.x * chaseSpeed	#change velocity to use chase speed
		
	
		if shootTimer.is_stopped():
			shoot()
			
		var collision = move_and_collide(velocity * delta)
		
	else:
		#walk around aimlessly
		var collision = move_and_collide(velocity * delta)
		if collision:
			speed = speed * -1
			
			if speed < 0:
				enemySprite.set_flip_h(true)
			else:
				enemySprite.set_flip_h(false)
			
			
			velocity.y += speed
			velocity = move_and_collide(velocity * delta)
		
	
func SimpleAI(delta):
	
	
	velocity = transform.x * speed	#this is fine unless it spots the player
	distanceToPlayer = DistanceToPlayer(player.position, position)
	#print(distanceToPlayer)
	#replace with upon detection
	#basic AI idea: walk around aimlessly until player detected, then walk toward them and fire
	
	if distanceToPlayer <= spotPlayerDistance or IGotShot == true:
		playerDetected = true
	else:
		playerDetected = false
	
	
	#make function that does below:(remember what an exponent really is for ^1/2)
	
	if playerDetected:
		#go towards the player
		look_at(player.position)
		velocity = transform.x * chaseSpeed	#change velocity to use chase speed
		
	
		if shootTimer.is_stopped():
			shoot()
			
		var collision = move_and_collide(velocity * delta)
		
	else:
		#patrol
		var collision = move_and_collide(velocity * delta)
		if collision:
			velocity = velocity.bounce(collision.normal).rotated(rand_range(-PI/4, PI/4))
		rotation = velocity.angle()
	



func _physics_process(delta):
	if blinkTimer.is_stopped():
		enemySprite.set_modulate(Color(1,1,1,1))
		
	SimpleAI(delta)
	#if another enemy class wants to use a different AI they can replace this function with another
	
		
	
