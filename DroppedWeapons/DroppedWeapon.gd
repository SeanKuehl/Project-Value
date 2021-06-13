extends Area2D


var weaponPlayerWillPickUp = load("res://Weapons/Weapon.tscn")
var weaponName = "pistol"
onready var player = get_node('../Player') #this is based on what the player is called in the scene tree, not it's actual scene
var distanceToPlayer = 0
var playerInsidePickupArea = false

func _ready():
	pass


#when player enters area, they are able to pickup gun, check this in physics process
#when player leaves they cannot

func _on_Area2D_body_entered(entity):
	
	if entity.is_in_group("Enemy"):
		pass
		#do noting, enemies don't pick up weapons
	if entity.is_in_group("Player"):
		
		playerInsidePickupArea = true
		#do the weapon pickup code with the player, and disappear
		#entity.PlayerPickupWeapon(weaponPlayerWillPickUp.instance())
		#maybe deal damage to player, or maybe have different bullets for enemies
		#queue_free()	
	
func _physics_process(delta):
	#distanceToPlayer = DistanceToPlayer(player.position, position)
	if playerInsidePickupArea == true:
		var worked = player.PlayerPickupWeapon(weaponPlayerWillPickUp.instance())
		if worked:
			queue_free()
	#print(distanceToPlayer)
	
	


func _on_Area2D_body_exited(body):
	if body.is_in_group("Player"):
		
		playerInsidePickupArea = false
