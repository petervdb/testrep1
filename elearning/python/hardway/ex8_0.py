# A formatter
formatter = "%r %r %r %r"

# Numbers do not show quotes
print formatter % (1, 2, 3, 4)
# strings will have quotes
print formatter % ("one", "two", "three", "four")
# Binary stuff
print formatter % (True, False, False, True)
# Formatter for the formatter
print formatter % (formatter, formatter, formatter, formatter)
# Show some text
print formatter % (
"I had this thing.",
"That you could type up right.",
"But it didn't sing.",
"So I said goodnight."
)
