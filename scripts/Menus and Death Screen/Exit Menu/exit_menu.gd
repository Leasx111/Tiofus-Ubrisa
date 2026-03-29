extends Control

class_name ExitMenu

@onready var main_scene : Node2D = $"/root/MainScene"

@export var level_menu : LevelMenu
@export var tutorial: TutorialMenu
@export var skill_tree_menu: Control
@export var player : Player

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void :
	
	pass

func _on_exit_pressed() -> void:
	
	get_tree().paused = false
	
	var main_menu = load("res://scenes/Menus and Death Screen/Menus/main_menu.tscn")
	
	get_parent().get_parent().get_parent().queue_free()
	
	main_scene.add_child(main_menu.instantiate())

func _input(event: InputEvent) -> void : 
	
	if event.is_action_released("toggle_exit_menu") and not level_menu.visible and not skill_tree_menu.visible and not tutorial.visible and player.state != player.States.dead :
		
		visible = not visible
		
		get_tree().paused = not get_tree().paused 
