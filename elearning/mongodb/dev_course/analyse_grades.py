from pymongo import Connection

if __name__ == "__main__":
	con = Connection()
	db = con.students

	grades = db.grades

	allgrades = grades.find()

	print "Show all grades"
	for grade in allgrades:
		print grade

