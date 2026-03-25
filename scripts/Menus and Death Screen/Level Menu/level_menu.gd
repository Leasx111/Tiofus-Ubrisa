extends Control

class_name LevelMenu

# Object instances
@export var player : Player
@export var tutorial: TutorialMenu
@export var skill_tree_menu: Control
@export var luck_value: Label
@export var attack_value: Label
@export var temperance_value: Label
@export var arcane_value: Label
@export var current_points : Label
@export var xp_to_next_level : Label

func _process(_delta: float) -> void :
	
	if visible :
		
		update_text()

func _on_luck_up_pressed() -> void :
	
	if SaveData.player_data.luck < 99 and SaveData.player_data.level_up_points > 0 :
		
		SaveData.player_data.level_up_points -= 1
		
		SaveData.player_data.luck += 1

func _on_attack_up_pressed() -> void :
	
	if SaveData.player_data.attack < 99 and SaveData.player_data.level_up_points > 0 :
		
		SaveData.player_data.level_up_points -= 1
		
		SaveData.player_data.attack += 1

func _on_temperance_up_pressed() -> void :
	
	if SaveData.player_data.temperance < 99 and SaveData.player_data.level_up_points > 0 :
		
		SaveData.player_data.level_up_points -= 1
		
		SaveData.player_data.temperance += 1

func _on_arcane_up_pressed() -> void :
	
	if SaveData.player_data.arcane < 99 and SaveData.player_data.level_up_points > 0 :
		
		SaveData.player_data.level_up_points -= 1
		
		SaveData.player_data.arcane += 1

func _on_luck_down_pressed() -> void :
	
	if SaveData.player_data.luck > 0 :
		
		SaveData.player_data.level_up_points += 1 
		
		SaveData.player_data.luck -= 1

func _on_attack_down_pressed() -> void :
	
	if SaveData.player_data.attack > 0 :
		
		SaveData.player_data.level_up_points += 1 
		
		SaveData.player_data.attack -= 1

func _on_temperance_down_pressed() -> void :
	
	if SaveData.player_data.temperance > 0 :
		
		SaveData.player_data.level_up_points += 1 
		
		SaveData.player_data.temperance -= 1

func _on_arcane_down_pressed() -> void :
	
	if SaveData.player_data.arcane > 0 :
		
		SaveData.player_data.level_up_points += 1 
		
		SaveData.player_data.arcane -= 1

# Update text
func update_text() : 
	
	@warning_ignore("narrowing_conversion")
	SaveData.player_data.XP_to_next_level = player.player_exp.max_value - player.player_exp.value
	
	luck_value.text = str(SaveData.player_data.luck)
	attack_value.text = str(SaveData.player_data.attack)
	temperance_value.text = str(SaveData.player_data.temperance)
	arcane_value.text = str(SaveData.player_data.arcane)
	
	current_points.text = "Current points : " + str(SaveData.player_data.level_up_points) 
	xp_to_next_level.text = "XP to next level : " + str(SaveData.player_data.XP_to_next_level)

func _input(event: InputEvent) -> void :
	
	if event.is_action_released("toggle_level_menu") and not tutorial.visible  and not skill_tree_menu.visible and player.state != player.States.dead :
		
		visible = not visible
