extends "res://Bullets/Bullet.gd"


#this will be an invisible, stationary bullet that will handle melee
#with the knife
onready var lifeTimer = $ExistenceTimer

func _ready():
	damage = 50
	bulletName = "knife bullet"
	speed = 0	#the bullet shouldn't move
	lifeTimer.start()
	
	
func _physics_process(delta):
	if lifeTimer.is_stopped():
		queue_free()
	._physics_process(delta)
