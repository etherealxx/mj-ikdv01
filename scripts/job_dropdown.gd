extends Control

@export_file("*.csv") var joblist_file = ""

var job_table := Dictionary() # job id as key, and the whole table row as value

var job_properties := Array()

func _ready():
	
	if !joblist_file.is_empty():
		var file = FileAccess.open(joblist_file, FileAccess.READ)
		
		# custom parser since godot doesn't have one by default
		# for non-translation csv data
		var next_csv_line := file.get_csv_line(",")
		var firstrow_init := false
		while next_csv_line != PackedStringArray([""]): # iterate every row
			var i = 0
			
			# contains a single row with the column name as key
			var job_detail := Dictionary() 
			
			# iterate on each item in row
			# and fill the job_detail
			for item in next_csv_line:
				if !firstrow_init: 
					# keep the value of the first row as reference
					job_properties.append(item)
				else:
					# job_properties[i] is current column's name
					job_detail[job_properties[i]] = item 
					i += 1
			
			if firstrow_init:
				# leftmost item, in this case, ID
				var job_index = int(job_detail[job_properties[0]]) 
			
				job_table[job_index] = job_detail
					
			firstrow_init = true
			next_csv_line = file.get_csv_line(",")
		
		%DropdownGroup.job_table = job_table # sync the job_table with the dropdown group
		%DropdownGroup.initialize_menupopup()
