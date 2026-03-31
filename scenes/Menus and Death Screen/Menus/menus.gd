extends Control

class_name Menus

@export var level_menu: LevelMenu
@export var skill_tree_menu: Control
@export var settings_menu: Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_button_button_up() -> void:
	
	level_menu.visible = true
	skill_tree_menu.visible = false
	settings_menu.visible = false


func _on_button_2_button_up() -> void:
	
	level_menu.visible = false
	skill_tree_menu.visible = true
	settings_menu.visible = false


func _on_button_3_button_up() -> void:
	
	level_menu.visible = false
	skill_tree_menu.visible = false
	settings_menu.visible = true
