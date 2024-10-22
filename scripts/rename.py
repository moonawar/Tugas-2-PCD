import os

def rename_files_in_folder(folder_path):
    # Get all files in the folder
    files = os.listdir(folder_path)
    
    # Filter out Python files and sort the remaining files
    files = [f for f in files if not f.endswith('.py')]
    files.sort()

    for index, file_name in enumerate(files):
        # Get the file extension
        file_extension = os.path.splitext(file_name)[1]
        
        # Create the new file name with two-digit padded index
        new_file_name = f"{index}{file_extension}"
        
        # Create the full paths for the old and new file names
        old_file_path = os.path.join(folder_path, file_name)
        new_file_path = os.path.join(folder_path, new_file_name)
        
        # Rename the file
        os.rename(old_file_path, new_file_path)
        print(f'Renamed: {file_name} -> {new_file_name}')

# Usage example
folder_path = "../images"  # Replace with the path to your folder
rename_files_in_folder(folder_path)

