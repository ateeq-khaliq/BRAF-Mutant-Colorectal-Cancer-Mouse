import os
import shutil
from pathlib import Path

# Define the source directory (where your samples are)
SRC_DIR = Path("/N/project/cytassist/heather/Chrm_499_OHagan_IUB_FLEX15_Mouse_May2024/Chrm_499_OHagan_IUB_FLEX15_run6/outs/per_sample_outs")

# Define the destination directory (where you want to copy the files)
DEST_DIR = Path("/N/project/cytassist/heather/Chrm_499_OHagan_IUB_FLEX15_Mouse_May2024/Chrm_499_OHagan_IUB_FLEX15_run6/outs/collected_web_summaries")

def copy_and_rename_web_summaries():
    # Create the destination directory if it doesn't exist
    DEST_DIR.mkdir(parents=True, exist_ok=True)

    # Find all web_summary.html files and process them
    for file_path in SRC_DIR.rglob("web_summary.html"):
        # Get the parent directory name (sample name)
        sample_name = file_path.parent.name
        
        # Define the new file name
        new_file_name = f"{sample_name}_web_summary.html"
        
        # Copy and rename the file
        shutil.copy2(file_path, DEST_DIR / new_file_name)

    print(f"All web_summary.html files have been copied and renamed in {DEST_DIR}")

if __name__ == "__main__":
    copy_and_rename_web_summaries()
