extends Control

@export_file("*.csv") var joblist_file = ""

var job_table := Dictionary()
var job_properties := Array()

func _ready():
	
	if !joblist_file.is_empty():
		var file = FileAccess.open(joblist_file, FileAccess.READ)
		
		# custom parser since godot doesn't have one by default
		# for non-translation csv data
		var next_csv_line := file.get_csv_line(",")
		var firstrow_init := false
		while next_csv_line != PackedStringArray([""]):
			#print(str(next_csv_line))
			
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
		%DropdownGroup.job_table = job_table
		%DropdownGroup.initialize_menupopup()
			
		
