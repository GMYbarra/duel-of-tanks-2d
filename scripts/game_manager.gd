extends Node2D

var p1_score = 0
var p2_score = 0

@onready var p_2_score: Label = $scores/p2_score
@onready var p_1_score: Label = $scores/p1_score

const PLAYER_1 = preload("res://scenes/player_1.tscn")
const PLAYER_2 = preload("res://scenes/player_2.tscn")

@onready var game_over_screem: Control = $GameOverScreem
@onready var win_text: Label = $GameOverScreem/WinText

var score_limit = 2

func _process(delta):
	if p1_score == 2:
		get_tree().paused = true
		game_over_screem.visible = true
		win_text.text = "Player 1 has won"

	if p2_score == 2:
		get_tree().paused = true
		game_over_screem.visible = true
		win_text.text = "Player 2 has won"	
	
	
func increment_p1_score():
	p1_score += 1
	p_1_score.text = "P1: " + str(p1_score)	
	
func increment_p2_score():
	p2_score += 1
	p_2_score.text = "P2: " + str(p2_score)


func respawn_p1():
	var p1 = PLAYER_1.instantiate()
	#para que la instancia apareza a leatoriamente en la pantalla
	p1.position = Vector2(randf_range(65,1097),randf_range(50,606))
	add_child(p1)
	
func respawn_p2():
	var p2 = PLAYER_2.instantiate()
	#para que la instancia apareza a leatoriamente en la pantalla
	p2.position = Vector2(randf_range(65,1097),randf_range(50,606))
	add_child(p2)

#el nodod button se conecta con on_button_pressed
func _on_button_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()
