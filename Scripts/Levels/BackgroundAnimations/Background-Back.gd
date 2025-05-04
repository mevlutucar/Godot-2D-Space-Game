extends ParallaxLayer

@export var BackGroundBackSpeed : int = +20

func _process(delta) -> void :
	
	self.motion_offset.x += BackGroundBackSpeed * delta
