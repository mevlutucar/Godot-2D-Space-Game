extends Area2D

@export var laserSpeed : int = 750

func _ready():
	$Sprite2D.scale = Vector2(0,0)
	var tweenAnimate = create_tween()
	tweenAnimate.tween_property($Sprite2D, 'scale',Vector2(2,2), 0.3)

func _process(delta):
	position.y -= laserSpeed * delta
