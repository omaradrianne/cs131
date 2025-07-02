#!/bin/bash
# tell the system to run this script with the Bash shell

# ask user for the dataset URL
echo -n "Enter url: " # print prompt without a newline so user input remain on same line
read url # wait, read user input, and store it in url variable

# download the file
echo "Downloading..."
filename=$(basename "$url") # basename strips the path from url, wine+quality.zip remains

# curl downloads from the internet
# $url is the url to fetch
# -o "$filename" saves the download to the filename we determined above
curl "$url" -o "$filename"

# unzip if it is a zip file
# if filename is ends with .zip then unzip
# 
if [[ "$filename" == *.zip ]]; then
	echo "Unzipping..."
	
	# unzip extracts zip files
	# -o overwrite existing files without asking
	# $filename is the zip file to unzip
	unzip -o "$filename" # Extract all the contents of zip into working directory
	
	# bash array assignment with command substitution
	# unzip -l "$filename" lists contents of the zip
	# filter for lines ending in .csv
	# $NF means "the last field" in awk
	csvfiles=( $(unzip -l "$filename" | awk '/.csv$/ {print $NF}') )
else
	# if not a zip, treat the downloaded file as a csv
	# and place in array for consistency with the zipped case
	csvfiles=("$filename")
fi

# loop through each CSV found within the zip file
for csvfile in "${csvfiles[@]}"; do # for all items of array csvfiles, do
	echo "Processing CSV: $csvfile"

	header=$(head -1 "$csvfile") # grab the first line of the csv, header row
	
	# set the internal field separator row to semicolon
	# -r: don't treat backslashes as escapes
	# -a stores the semicolon separated header as an array called columns
	IFS=';' read -ra columns <<< "$header"
	
	# clean up quotes from each column name
	# traverse the columns array and remove quotations using sed substitution
	for i in "${!columns[@]}"; do
		columns[$i]=$(echo "${columns[$i]}" | sed 's/"//g')
	done
	
	echo "Columns found in $csvfile:"
	for i in "${!columns[@]}"; do # provide the array indeces 0 to n-1
		echo "$((i+1)). ${columns[$i]}" # display the columns with 1-based index
	done
	
	# ask for numeric column indexes
	# here we prompt the user to tell us which columns are numeric
	# we then split the input into the num_indices array
	echo "Enter numeric column indexes for $csvfile separated by comma (e.g., 1,3,4): "
	read numcols
	IFS=',' read -a num_indices <<< "$numcols"

	# writing the summary
	summary="summary-${csvfile%.csv}.md" # strip .csv off and treated as filename
	echo "# Feature Summary for $csvfile" > "$summary" # redirect output to summary
	echo "" >> "$summary"
	echo "## Feature Index and Names" >> "$summary"
	for i in "${!columns[@]}"; do
		echo "$((i+1)). ${columns[$i]}" >> "$summary"
	done

	echo "" >> "$summary"
	echo "## Statistics (Numerical Features)" >> "$summary"
	echo "" >> "$summary"
	
	# markdown table
	echo "| Index | Feature | Min | Max | Mean | StdDev |" >> "$summary"
	echo "|-------|---------|-----|-----|------|--------|" >> "$summary"

	# IMPORTANT: subsequent code is AI-GENERATED to provide proper demonstration output	
	# process each numeric column
	for idx in "${num_indices[@]}"; do
        	col=$((idx))
        	feature=${columns[$((col-1))]} # look up feature name

		# awk block to compute min, max, sum, mean, standard deviation
        	stats=$(awk -F';' -v col="$col" '
        	NR>1 {
        		val=$col+0;
        		if (min=="") {min=max=val}
            		if (val<min) {min=val}
        		if (val>max) {max=val}
            		sum+=val;
            		sumsq+=val*val;
            		n++;
        	}
        	END {
            		mean = sum/n;
            		stddev = sqrt((sumsq/n) - (mean*mean));
            		printf "%.4f %.4f %.4f %.4f", min, max, mean, stddev
        	}
        	' "$csvfile")

        	min=$(echo $stats | awk '{print $1}')
        	max=$(echo $stats | awk '{print $2}')
        	mean=$(echo $stats | awk '{print $3}')
        	stddev=$(echo $stats | awk '{print $4}')
	
		# append a markdown table row for that numeric column
        	echo "| $col | $feature | $min | $max | $mean | $stddev |" >> "$summary"
	done	
	echo "Summary saved to $summary"
	
done
