extends Area2D

#bullets will need damage, speed, a name, self destroy on walls(that maybe alert enemies)
var damage = 10
var bulletName = "pistol bullet"
var speed = 600

func _ready():
	pass

func _physics_process(delta):
	position += transform.x * speed * delta

func _on_Area2D_body_entered(entity):
	WhenEntered(entity)
	
	
	
#this function is here because a connection still needs to be made to the script, but
#this function can be called in that connection function
func WhenEntered(entity):
	if entity.is_in_group("Enemy"):
		entity.I_Got_Hit(damage)
		#maybe call a function in the enemy and pass in the bullets damage,
		#make enemy flash red when they are hit
		
		#deal the bullets damage to the enemy
	if entity.is_in_group("Player"):
		pass
		#maybe deal damage to player, or maybe have different bullets for enemies
	queue_free()	#destroy the bullet if it collided with a wall
	
	
