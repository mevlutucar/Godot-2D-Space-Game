extends ParallaxLayer

@export var BackGroundStarsSpeed : int = +35

func _process(delta) -> void :
	
	self.motion_offset.y += BackGroundStarsSpeed * delta
