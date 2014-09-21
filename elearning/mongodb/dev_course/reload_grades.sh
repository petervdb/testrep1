# To reload grades collection in te students database.
# I there are elements you can ignore the warnings

mongoimport -d students -c grades < grades.json
