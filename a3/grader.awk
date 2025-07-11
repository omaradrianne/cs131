# Author: Omar Adrianne Bapora
# Date: July 11, 2025
# Awk program (comments included)
# Command: awk -f grader.awk grades.csv

# Calculates the average grade/score of a given student and returns the value
# key: student names
# array: gradeSum
function calculateAverageGrade(array, key) {
    return array[key] / divisor
}

BEGIN {
    printf "a3-25su\n\n"
    FS="," # Field separator set to comma
    divisor = 3 # Corresponds to the total number of courses
    currentLowestScore = 9999999999 # Dummy maximum score value
    currentHighestScore = -1 # Dummy minimum score value
}

# NR > 1 excludes the header row
NR > 1 {
    # Unique keys (student names) are used to build two separate arrays:
    # gradeSum: array containing each student's total score
    # gradeAvg: array containing each student's average score
    gradeSum[$2] = $3 + $4 + $5
    gradeAvg[$2] = calculateAverageGrade(gradeSum, $2) # Invokes calculateAverageGrade()
    if (gradeAvg[$2] >= 70) {
        status[$2] = "Pass" # Initialize pass/fail status array per student
    } else {
        status[$2] = "Fail" # Initialize pass/fail status array per student
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
    # n for name (the key)
    for (n in gradeSum) { # Alternative: for (i=0; i<indx; i++) req. names arr. & indx
        print "Student name: " n
	print "Total score: " gradeSum[n]
	print "Average score: " gradeAvg[n]
	printf "Status: " status[n] "\n\n"
    }
    
    # Output top/lowest scoring students
    print "Top scoring student: " studentWithHighest
    print "Lowest scoring student: " studentWithLowest
}
