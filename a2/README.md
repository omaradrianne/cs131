# datacollector.sh

datacollectior.sh is a shell script that automates the download
and summary generation of CSV datasets.

IMPORTANT: The summary statistic output is the result of AI-generated
	   code for demonstration purposes only, and is not a reflection
	   of current ability.

## Installation

Install the "unzip" program, which is needed to extract .zip files.

sudo apt update
sudo apt install unzip

## Usage

1. Make the script executable:

chmod 555 datacollector.sh

2. Run the script:

./datacollector.sh

3. When prompted, provide:

   * the URL to the dataset (CSV or ZIP containing CSVs)
   * the numeric column indexes (e.g., 1,3,4) for summarization

4. The script will automatically:
   
   * download and extract files
   * display feature names with their indices
   * generate a summary for each CSV with basic statistics

## License

This project is for educational and demonstration purposes.
