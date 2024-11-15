extends HBoxContainer

@export_file("*.csv") var joblist_file = ""

@onready var menupopup : PopupMenu = %MenuButton.get_popup()

var job_table := Dictionary()
var job_properties := Array()

func _ready():
	menupopup.id_pressed.connect(_on_popup_item_pressed)
	
	if !joblist_file.is_empty():
		var file = FileAccess.open(joblist_file, FileAccess.READ)
		
		# custom parser since godot doesn't have one by default
		# for non-translation csv data
		var next_csv_line := file.get_csv_line(",")
		var firstrow_init := false
		while next_csv_line != PackedStringArray([""]):
			print(str(next_csv_line))
			
			#var column = 1 
			var i = 0
			var job_detail := Dictionary()
			for item in next_csv_line:
				if !firstrow_init:
					#job_table[item] = Array()
					#job_table[column] = item
					#column += 1
					job_properties.append(item)
				else:
					job_detail[job_properties[i]] = item
					i += 1
			
			if firstrow_init:
				print(str(job_detail))

				var job_index = int(job_detail[job_properties[0]]) # leftmost item
			
				job_table[job_index] = job_detail
					
			#var column = 1 
			#for item in next_csv_line:
				#if !firstrow_init:
					#job_table[item] = Array()
					#job_table[column] = item
					#column += 1
				#else:
					#job_table[job_table[column]][]
					
			firstrow_init = true
			next_csv_line = file.get_csv_line(",")
		
		#print(str(job_table))
		#print(job_table[1])
		for job_item in job_table.keys():
			menupopup.add_item(job_table[job_item]["JOBNAME"])

func _on_popup_item_pressed(id):
	%MenuButton.text = menupopup.get_item_text(menupopup.get_item_index(id))
