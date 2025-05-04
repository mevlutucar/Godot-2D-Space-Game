extends ParallaxLayer

@export var BackGroundPlanetSpeed : int = +15

func _process(delta) -> void :
	
	self.motion_offset.x += BackGroundPlanetSpeed * delta
