extends HBoxContainer

@export_file("*.csv") var joblist_file = ""

func _ready():
	if !joblist_file.is_empty():
		var file = FileAccess.open(joblist_file, FileAccess.READ)
		
		# custom parser since godot doesn't have one by default
		# for non-translation csv data
		var next_csv_line = file.get_csv_line(",")
		while next_csv_line != PackedStringArray([""]):
			print(str(next_csv_line))
			next_csv_line = file.get_csv_line(",")
