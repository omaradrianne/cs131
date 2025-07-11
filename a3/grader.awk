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
    currentLowestScore = 9999999999
    currentHighestScore = -1
}

# NR > 1 excludes the header row
NR > 1 {
    # Use unique keys (student names) to build two separate arrays:
    # gradeSum and gradeAvg
    gradeSum[$2] = $3 + $4 + $5
    gradeAvg[$2] = calculateAverageGrade(gradeSum, $2) # invokes calculateAverageGrade()
    printf $2 "'s average grade is " gradeAvg[$2] " "
    if (gradeAvg[$2] >= 70) {
        print "[PASS]"
        status[$2] = "PASS" # Initialize pass/fail status array per student
    } else {
        print "[FAIL]"
        status[$2] = "FAIL"
    }
    
    # Determine lowest scoring student
    if (gradeSum[$2] < currentLowestScore) {
        currentLowestScore = gradeSum[$2]
        studentWithLowest = $2
    }
    
    # Determine highest scoring student
    if (gradeSum[$2] > currentHighestScore) {
        currentHighestScore = gradeSum[$2]
	studentWithHighest = $2
    }
}

END {
    # s for student (the key)
    # for (s in gradeSum)

    printf "\nStudent with the lowest score: " studentWithLowest "\n"
    print "Total score: " gradeSum[studentWithLowest]
    print "Status: " status[studentWithLowest]
    
    print "Student with the highest score: " studentWithHighest
    print "Total score: " gradeSum[studentWithHighest]
    print "Status: " status[studentWithHighest]    
}
