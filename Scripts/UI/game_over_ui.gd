extends Control

var level_scene: PackedScene = load("res://Scenes/Level/level.tscn") 

func _ready():
	$GameOverScoreContainer/VBoxContainer/GameOverLabel.text = str('GAME OVER')
	$GameOverScoreContainer/VBoxContainer/YourScoreLabel.text = str('YOUR SCORE: ', Global.score)

func _process(_delta):
	restart_game()
	
func restart_game():
	if Input.is_action_just_pressed("GameOverRestart"):
		get_tree().change_scene_to_packed(level_scene)
		Global.score = 0
		Global.meteorExplodeScore = 0
