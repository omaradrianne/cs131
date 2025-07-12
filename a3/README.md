# grader.awk

grader.awk is an AWK script that reads a CSV file of student grades and calculates
the total and average scores for each student, determines pass/fail status, and
identifies the highest and lowest scoring students.

## File Overview
Script: grader.awk
Input: grades.csv (CSV file with student names and grades)
Command to run: awk -f grader.awk grades.csv

## Script Features
Parses CSV with fields: ID, Name, Grade1, Grade2, Grade3

Computes total score, average score, and pass/fail status per student
(Pass if average score >= 70, otherwise Fail)

Identifies highest and lowest scoring students

Formatted output for each student:
Name
Total score
Average score
Pass/Fail status

## Sample CSV Format
StudentID,Name,CS146,CS131,CS100W
101,Alice,85,90,78
102,Bob,76,82,88
103,Charlie,90,85,95
104,David,65,70,60
105,Eve,88,92,85

## Sample Output
a3-25su

Student name: David
Total score: 195
Average score: 65
Status: Fail

Student name: Eve
Total score: 265
Average score: 88.3333
Status: Pass

Student name: Bob
Total score: 246
Average score: 82
Status: Pass

Student name: Charlie
Total score: 270
Average score: 90
Status: Pass

Student name: Alice
Total score: 253
Average score: 84.3333
Status: Pass

Top scoring student: Charlie
Lowest scoring student: David

## Script Structure
BEGIN block:
Sets the field separator to a comma (,)
Initializes a divisor (3) for averaging grades
Sets dummy extreme values for min/max score tracking

Main block (NR > 1):
Skips the CSV header
Calculates total scores and averages
Determines pass/fail status
Tracks highest and lowest total scores and saves
the corresponding student names

END block:
Loops through each student to print results
Displays top and bottom scorers

## Requirements
Unix-like environment
AWK

## Note (limitation)
Designed for an input file with exactly 3 grades per student.

## License
This assignment is for educational and demonstration purposes.
