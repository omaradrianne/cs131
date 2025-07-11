# Awk program (comments included)
# Command: awk -f grader.awk grades.csv

# key: student names
# array: gradeSum
function calculateAverageGrade(array, key) {
    return array[key] / divisor
}

BEGIN {
    print "a3-25su"
    FS=","
    divisor = 3
}

# NR > 1 excludes the header row.
NR > 1 {
    # Use unique keys (student names) to build two separate arrays:
    # gradeSum and gradeAvg
    gradeSum[$2] = $3 + $4 + $5
    gradeAvg[$2] = calculateAverageGrade(gradeSum, $2) # invokes calculateAverageGrade()
    printf $2 "'s average grade is " gradeAvg[$2] " "
    if (gradeAvg[$2] >= 70)
        print "[PASS]"
    else
        print "[FAIL]"
}

END {
    # s for student
    # for (s in gradeSum)
        # print s "'s total grade is", gradeSum[s] "."
	
	# print s "'s grade average is", calculateAverageGrade(gradeSum, s)
}
