extends HBoxContainer

var job_table := Dictionary()
var job_key_id_val := Dictionary()
@onready var menupopup : PopupMenu = %MenuButton.get_popup()

func _ready():
	%JobName.set_text("")
	%JobDesc.set_text("")
	menupopup.id_pressed.connect(_on_popup_item_pressed)

func _on_popup_item_pressed(id):
	var index = menupopup.get_item_index(id)
	var job_name = menupopup.get_item_text(index)
	%MenuButton.text = job_name
	var job_id : int = job_key_id_val[job_name]
	%JobName.text = job_table[job_id]["JOBNAME"]
	%JobDesc.text = job_table[job_id]["DESCRIPTION"]
	
	var all_skills : String = job_table[job_id]["SKILLS"]
	var skill_list : PackedStringArray = all_skills.split(";")
	$ItemList.clear()
	for skill in skill_list:
		$ItemList.add_item(skill.strip_edges())

#func add_item_to_menupopup(item : String):
	#menupopup.add_item(item)

func initialize_menupopup():
		for job_item in job_table.keys():
			var job_name = job_table[job_item]["JOBNAME"]
			menupopup.add_item(job_name)
			job_key_id_val[job_name] = int(job_table[job_item]["ID"])
