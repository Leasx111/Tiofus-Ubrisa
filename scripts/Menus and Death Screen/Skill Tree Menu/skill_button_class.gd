extends Button

class_name SkillButton

@export var next_button : Array[NodePath]

@export var other_path : SkillButton
@export var other_path1 : SkillButton
@export var other_path2 : SkillButton

@export var skill_description_text : Label

@export var skill_name : String
@export var skill_description : String 

@export var unlocked : bool = false


func _pressed() -> void :
	
	
	if SaveData.player_data.level_up_points > 0 :
		
		unlocked = true
		
		self.disabled = true
		
		self.add_theme_color_override("icon_disabled_color", Color(1,1,1))
		
		for i in next_button.size() :
			
			var node = get_node(next_button[i])
			
			if node.disabled :
				
				node.disabled = false
		
		if other_path :
			
			other_path.disabled = true
			
			other_path1.disabled = true
			
			other_path2.disabled = true
		
		SaveData.player_data.unlocked_skills.push_back(skill_name)
		
		SaveData.player_data.level_up_points -= 1
	
	else :
		
		skill_description_text.text = "No points avaiable. you obtain 1 every 10 levels !!"


func _on_mouse_entered() -> void:
	
	skill_description_text.visible = true
	
	skill_description_text.text = skill_name + " : " + "\n" + "\n" + skill_description


func _on_mouse_exited() -> void:
	
	skill_description_text.text = " "
