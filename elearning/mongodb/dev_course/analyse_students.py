import pymongo

con = pymongo.Connection()
db = con.school

students = db.students

amount = students.count()

print "Amount of elements in students: %s " % amount

exam_el = students.find({ "scores.type" : "exam" }).count()
print "Amount of exam types in students: %s " % exam_el
        
quiz_el = students.find({ "scores.type" : "quiz" }).count()
print "Amount of quiz types in students: %s " % quiz_el

homework_el = students.find({ "scores.type" : "homework" }).count()
print "Amount of homework types in students: %s " % homework_el

# Filter homework elements and get lowest grades first
allhomework = students.find()
# allhomework = allhomework.sort( ["student_id", pymongo.ASCENDING])

print "Show all homework"
for homework in allhomework:
        # print grade
        student_id = homework['_id']
        student_name = homework['name']
        student_results = homework['scores']
        exam = student_results[0]
        exam_score = exam['score']
        quiz = student_results[1]
        quiz_score = quiz['score']
        homework1 = student_results[2]
        homework1_score = homework1['score']
        homework2 = student_results[3]
        homework2_score = homework2['score']
        if homework1_score < homework2_score:
                best_homework = homework2_score
        else:
                best_homework = homework1_score
                
        # cur_score = homework['scores.type']
        # cur_score2 = homework['scores.type']
        # print "Student: %s Score: %s" % (cur_student, cur_score)
        # print "Students %s : %s - Homework with grades: %s and %s" % (student_id, student_name, cur_score, cur_score2)
        # grades.remove({"_id": student_obj_id})
        # print "Student_results: %s" % student_results
        print "Students %s exam: %s - quiz: %s - homework1: %s - homework2: %s - bestscore: %s" % \
              (student_id, exam_score, quiz_score, homework1_score, homework2_score, best_homework)
        updateinfo = {"$set": { "scores": [ { "type": "exam", "score": exam_score },
                { "type": "quiz", "score": quiz_score },
                { "type": "homework", "score": best_homework } ] } }
        students.update({'_id' : student_id}, updateinfo )
        
