extends Control

class_name DeathScreen

@export var death_text : Label
@export var background : ColorRect
@export var text_background : Sprite2D
@export var player : Player
@export var exit_menu : ExitMenu
@export var level_menu : LevelMenu

var text_background_fade_duration : float = 2.0
var background_fade_duration : float = 5.0
var text_fade_duration : float = 2.0
var showable : bool = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void :
	
	pass

func fade_in() : 
	
	visible = true
	
	exit_menu.visible = false
	level_menu.visible = false
	
	var text_background_tween = get_tree().create_tween()
	var background_tween = get_tree().create_tween()
	var text_tween = get_tree().create_tween()
	
	text_background_tween.tween_property(text_background, "modulate:a", 1, text_background_fade_duration)
	background_tween.tween_property(background, "modulate:a", 1, background_fade_duration)
	text_tween.tween_property(death_text, "modulate:a", 1, text_fade_duration)
	
	text_background_tween.play()
	background_tween.play()
	text_tween.play()
	
	await background_tween.finished
	
	text_background_tween.kill()
	background_tween.kill()
	text_tween.kill()
	
	death_text.modulate = Color(0.996, 0.0, 0.0, 0.004)
	text_background.modulate = 0
	background.modulate = 0
	
	player.respawn()
