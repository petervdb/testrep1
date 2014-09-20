from pymongo import Connection

if __name__ == "__main__":
	con = Connection()
	db = con.test_database

	people = db.people
	people.insert({'name' : 'Peter', 'food' : 'chocolate'} )

	peeps = people.find()

	print "Insert & find test"
	for person in peeps:
		print person

