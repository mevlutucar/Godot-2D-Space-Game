extends CanvasLayer
var level_scene: PackedScene = load("res://Scenes/Level/level.tscn") 
var timeElapsed := 0

static var healthImage = load("res://Graphics & Sounds/Ship/2.png")
#1 Level sahnesinde mevcut canı göster.
func set_health(healthAmount):
#2 UI'da tüm childrenları kaldır.
	for child in $ShipLifeMarginContainer/HBoxContainer.get_children(): #Childrenları çektik.
		child.queue_free() #Childrenları kaldırdık.

#3 UI'da,yeni childrenları health değerine göre ekle.
	for i in healthAmount:
		var texture_rect = TextureRect.new() #Child texture oluşturduk.
		texture_rect.texture = healthImage
		$ShipLifeMarginContainer/HBoxContainer.add_child(texture_rect)
		texture_rect.stretch_mode = TextureRect.STRETCH_KEEP


func _on_score_timer_timeout():
	timeElapsed +=1
	Global.score = Global.meteorExplodeScore + timeElapsed
	$ScoreMarginContainer/ScoreLabelTop.text = str('SCORE: ', Global.score)
	print('UI Scriptindeki global explode değeri :' , Global.meteorExplodeScore)
