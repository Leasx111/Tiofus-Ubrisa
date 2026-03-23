extends Control

class_name ExitMenu

@export var level_menu : LevelMenu
@export var tutorial: TutorialMenu
@export var player : Player

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void :
	
	pass

func _on_exit_pressed() -> void:
	
	get_tree().paused = false
	
	get_tree().change_scene_to_file("res://scenes/Menus and Death Screen/Menus/main_menu.tscn")

func _input(event: InputEvent) -> void : 
	
	if event.is_action_released("toggle_exit_menu") and not level_menu.visible and not tutorial.visible and player.state != player.States.dead :
		
		visible = not visible
		
		get_tree().paused = not get_tree().paused 
