# Web Summary Collector

## Overview

This project contains a Python script that collects and renames web summary files from multiple samples in a spatial transcriptomics experiment. It's designed to work with output from the Chromium 499 OHagan IUB FLEX15 Mouse May2024 run.

## Purpose

In spatial transcriptomics experiments, each sample generates a `web_summary.html` file. These files are typically scattered across different sample directories. This script automates the process of:

1. Locating all `web_summary.html` files
2. Copying them to a central location
3. Renaming them to include their sample identifier

This makes it easier to access and compare web summaries across all samples in the experiment.

## Script Details

The main script is `collect_web_summaries.py`. Here's what it does:

- Searches for all `web_summary.html` files in the specified source directory and its subdirectories.
- Creates a new directory to store the collected files.
- Copies each `web_summary.html` file to the new directory.
- Renames each copied file to include the name of its parent folder (which is the sample name).

## Usage

1. Ensure you have Python installed on your system.
2. Clone this repository or download the `collect_web_summaries.py` script.
3. Modify the `SRC_DIR` and `DEST_DIR` variables in the script if your directory structure is different.
4. Run the script:

   ```
   python collect_web_summaries.py
   ```

5. After running, check the destination directory for the collected and renamed files.

## File Locations

- Source Directory (location of sample folders):
  ```
  /N/project/cytassist/heather/Chrm_499_OHagan_IUB_FLEX15_Mouse_May2024/Chrm_499_OHagan_IUB_FLEX15_run6/outs/per_sample_outs
  ```

- Destination Directory (where files are collected):
  ```
  /N/project/cytassist/heather/Chrm_499_OHagan_IUB_FLEX15_Mouse_May2024/Chrm_499_OHagan_IUB_FLEX15_run6/outs/collected_web_summaries
  ```

## Output

The script will create a new folder called `collected_web_summaries` containing all the web summary files, renamed according to their sample names. For example:

```
collected_web_summaries/
├── 0_web_summary.html
├── 959_web_summary.html
├── 960_web_summary.html
...
└── 983_web_summary.html
```

## Contributing

Feel free to fork this repository and submit pull requests with any enhancements.

## License

General

## Contact

Ateeq Khaliq
