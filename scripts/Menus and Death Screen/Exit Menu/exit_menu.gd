extends Control

class_name ExitMenu

@onready var main_scene : Node2D = $"/root/MainScene"
@onready var audio_stream_player: AudioStreamPlayer = $"/root/MainScene/AudioStreamPlayer"

@export var menu: Menus
@export var tutorial: TutorialMenu
@export var room_transition : RoomTransition
@export var player : Player

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void :
	
	pass

func _on_exit_pressed() -> void:
	
	get_tree().paused = false
	
	var main_menu : PackedScene = load("res://scenes/Menus and Death Screen/Menus/main_menu.tscn")
	
	get_parent().get_parent().get_parent().queue_free()
	
	main_scene.add_child(main_menu.instantiate())

func _input(event: InputEvent) -> void : 
	
	if event.is_action_released("toggle_exit_menu") and not menu.visible and not tutorial.visible and not room_transition.visible and player.state != player.States.dead :
		
		visible = not visible
		
		get_tree().paused = not get_tree().paused
		
		audio_stream_player.stop()
