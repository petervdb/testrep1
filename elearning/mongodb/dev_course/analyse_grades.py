import pymongo

con = pymongo.Connection()
db = con.students

grades = db.grades

amount = grades.count()

print "Amount of elements in grades: %s " % amount

exam_el = grades.find({ "type" : "exam" }).count()
print "Amount of exam types in grades: %s " % exam_el
        
quiz_el = grades.find({ "type" : "quiz" }).count()
print "Amount of quiz types in grades: %s " % quiz_el

homework_el = grades.find({ "type" : "homework" }).count()
print "Amount of homework types in grades: %s " % homework_el

# Filter homework elements and get lowest grades first
allhomework = grades.find({ "type" : "homework"})
allhomework = allhomework.sort( [["student_id", pymongo.ASCENDING], ["score", pymongo.ASCENDING ]])

print "Show all homework"
old_student = -1
for homework in allhomework:
        # print grade
        cur_student = homework['student_id']
        cur_score = homework['score']
        # print "Student: %s Score: %s" % (cur_student, cur_score)
        if old_student != cur_student:
                student_obj_id = homework['_id']
                print "Students %s Homework with grade %s needs to be removed ( %s )" % (cur_student, cur_score, student_obj_id)
                grades.remove({"_id": student_obj_id})
        else:
                print "Students %s best score is %s" % (cur_student, cur_score)
        old_student = cur_student
