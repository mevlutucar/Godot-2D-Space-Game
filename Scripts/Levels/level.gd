extends Node2D

var meteor_scene : PackedScene = load("res://Scenes/Meteor/meteor.tscn") #oluşturacağımız nesneye eriştik.

var laser_scene : PackedScene = load("res://Scenes/Laser/laser.tscn") # 1- Öncelikle signal sonucu oluşturulacak sahnenin(ana nesneye) pathine ulaşırız.

@onready var pause_menu = $PauseUI
var paused : bool = false

var health : int = 3

func _ready():
	#1 Level sahnesinde mevcut canı göster.
	get_tree().call_group('GroupUI', 'set_health', health)
	$MusicAndEffects/BGMusic.play()

func _process(delta):
	if Input.is_action_just_pressed("Pause"):
		pause_menu_operations()

func pause_menu_operations():
	if paused:
		pause_menu.hide()
		Engine.time_scale = 1
	else:
		pause_menu.show()
		Engine.time_scale = 0
		
	paused = !paused	

func _on_meteor_timer_timeout():
	var meteor = meteor_scene.instantiate() #meteoru oluşturduk.
	$Meteors.add_child(meteor) #Oluşturduğumuz meteorları, Meteors node'u altına atadık.
	meteor.connect('collisionEnter', on_meteor_collisionEnter) #Meteor sinyali ile karakterimizi connect yaptık.

func on_meteor_collisionEnter():
	health -=1
	get_tree().call_group('GroupUI', 'set_health', health)
	print('Can değeri :', health)
	if(health <= 0):
		get_tree().change_scene_to_file("res://Scenes/UI/game_over_ui.tscn")
		print('Canın bitti.')
	$Player.player_hit_sound()


func _on_player_laser_shoot(pos1, pos2):
	
	var laser = laser_scene.instantiate() # 2- Signal içinde pathine ulaştığımız sahnenin (ana nesnenin) instance olmasını sağlarız.
	var laser2 = laser_scene.instantiate() # 2- Signal içinde pathine ulaştığımız sahnenin (ana nesnenin) instance olmasını sağlarız.
	$Lasers.add_child(laser) # 3- instance olan ana nesnenin oluşturulmasını sağlarız.
	$Lasers.add_child(laser2) # 3- instance olan ana nesnenin oluşturulmasını sağlarız.
	laser.position = pos1 # 4- Signal ile ulaştığımız veriyi kullanırız.
	laser2.position = pos2 # 4- Signal ile ulaştığımız veriyi kullanırız.
	print('Laser 1 Pozisyonu :',pos1)
	print('Laser 2 Pozisyonu :', pos2)
