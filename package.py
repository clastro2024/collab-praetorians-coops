import os
import shutil
import zipfile
from datetime import datetime

# Define variables
main_mission_folder = 'Main Mission Files'
past_versions_folder = 'Past_Versions'
repo_root = r"D:\Sohan Sain\Games\Praetorians\Missions\MY OWN MISSIONS\collab with kison, jashan\praetorians-coops"
local_destination = r"D:\Sohan Sain"
package_name_variable = 'TestMissions'

# Get the absolute paths
main_mission_path = os.path.join(repo_root, main_mission_folder)
past_versions_path = os.path.join(repo_root, past_versions_folder)
local_destination_path = os.path.join(local_destination, f'{package_name_variable}.pak')

# Check if the .pak file exists in the repo root
pak_file_path = os.path.join(repo_root, f'{package_name_variable}.pak')
if os.path.exists(pak_file_path):
    # Rename the existing .pak file with current timestamp
    timestamp = datetime.now().strftime('%Y-%m-%d_%H-%M-%S')
    new_name = f'{package_name_variable}_{timestamp}.pak'
    shutil.move(pak_file_path, os.path.join(past_versions_path, new_name))

# Create a zip file from the main mission folder
with zipfile.ZipFile(os.path.join(repo_root, f'{package_name_variable}.zip'), 'w', zipfile.ZIP_DEFLATED) as zipf:
    for root, dirs, files in os.walk(main_mission_path):
        for file in files:
            zipf.write(os.path.join(root, file), os.path.relpath(os.path.join(root, file), main_mission_path))

# Move the zip file to the repo root and rename it to .pak
shutil.move(os.path.join(repo_root, f'{package_name_variable}.zip'), pak_file_path)

# Copy the .pak file to the local destination
shutil.copy(pak_file_path, local_destination_path)