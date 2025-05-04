extends Area2D

var meteorSpeed : int
var rotationDegree : int
var direction_x : float
var can_collide :bool = true

signal collisionEnter

func _ready():
	$ExplodeAnimation.hide()
	var rng := RandomNumberGenerator.new()
	var width= get_viewport().get_visible_rect().size[0] #viewportun yatay uzunluğunu (X) alırız.
	var randomX = rng.randi_range(0, width)
	print('olusutulan random x koordinati :' ,randomX) # 0 - viewport boyutu aralığında random x koordinatları oluşturduk.
	var randomY = rng.randi_range(-150, -50) # -150 , -50 aralığında random y koordinatları oluşturduk.
	print('olusutulan random y koordinati :' ,randomY)
	position = Vector2(randomX,randomY) #oluşturulan meteorların pozisyonları tutuldu.
	
	meteorSpeed = rng.randi_range(50,250) # rastgele meteor hızı oluşturduk.
	rotationDegree = rng.randi_range(40,100) # rastgele meteor rotasyon derecesi oluşturduk.
	direction_x = rng.randf_range(-1,1) # rastgele x konumları oluşturduk.
	
	var path: String = "res://Graphics & Sounds/Meteors/" + str(rng.randi_range(1,4)) + ".png" #Meteors klasörü içindeki meteorlardan rastgele seçme
	$Sprite2D.texture = load(path) #Rastgele seçilen meteorları texture'a aktarma.
func _process(delta):
	position += Vector2(direction_x, 1.0) * meteorSpeed * delta #meteorların aşağı doğru rastgele x konumlarında olacak şekilde ilerlemesini sağladık.
	rotation_degrees += rotationDegree * delta

func _on_body_entered(_body):
	if can_collide:
		collisionEnter.emit()


func _on_area_entered(area):
	area.queue_free() #laser
	$ExplosionSound.play()
	$Sprite2D.hide()
	$CollisionShape2D.hide()
	can_collide = false
	await get_tree().create_timer(0.5).timeout
	queue_free() #meteor
	Global.meteorExplodeScore += 10
