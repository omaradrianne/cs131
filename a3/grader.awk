# Awk program (comments included)
# Command: awk -f grader.awk grades.csv

BEGIN {
    print "a3-25su"
    FS=","
}

# NR > 1 excludes the header row.
NR > 1 {
    # Set each key as the student name.
    gradeSum[$2] = $3 + $4 + $5
}

END {
    for (s in gradeSum)
        print s "\'s total grade is", gradeSum[s] "."
}
