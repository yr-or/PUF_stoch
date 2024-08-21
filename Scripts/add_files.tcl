# Set the path to the folder containing the files
set folder_path "C:/Users/Rory/Documents/HDL/PUF_stoch/PUF_stoch.srcs/sources_1/new/"

# Get the list of all files in the folder
set file_list [glob -nocomplain -directory $folder_path *]

# Add each file to the project
foreach file $file_list {
    add_files $file
}

# Set the path to the folder containing the files
set folder_path "C:/Users/Rory/Documents/HDL/PUF_stoch/PUF_stoch.srcs/sim_1/new/"

# Get the list of all files in the folder
set file_list [glob -nocomplain -directory $folder_path *]

# Add each file to the project
foreach file $file_list {
    add_files $file
}

# Optionally, update the project after adding the files
update_compile_order -fileset sources_1
update_compile_order -fileset sim_1
