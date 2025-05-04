extends CharacterBody2D

@export var speed:int = 400
@export var acceleration : int = 20
var canShoot : bool = true

signal laserShoot(pos1, pos2)
 
func _ready():
	position = Vector2(400,1200)
	

func _process(_delta) -> void :
	var direction : Vector2 = Input.get_vector("Left","Right","Up","Down")
	
	velocity.x = move_toward(velocity.x, speed * direction.x , acceleration)
	velocity.y = move_toward(velocity.y, speed * direction.y, acceleration)
	move_and_slide()
	
	if Input.is_action_just_pressed("Shoot") and canShoot:
		#Signal 2 değişken içerdiği için, değişkenleri peş peşe tek emit komutunda yollamak gerekir.
		laserShoot.emit($LaserPosition.global_position, $LaserPosition2.global_position)
		$LaserShotSound.play()
		canShoot = false
		$LaserShootTimer.start()
		
func _on_laser_shoot_timer_timeout():
	canShoot = true
	
func player_hit_sound():
	$PlayerHitSound.play()
