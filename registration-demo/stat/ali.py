import pandas as pd

# Load the actual data from CSV files
blockdata = pd.read_csv("data/blockdata/Student_best_block (1).csv")
gradedata = pd.read_csv("data/Student Grade/CombinedActiveStudents2.csv")

# Print shapes of loaded datasets
print(f'Blockdata shape: {blockdata.shape}')
print(f'Gradedata shape: {gradedata.shape}')

# Filter CombinedActiveStudents2 to include only rows where curriculum is 'Artificial Intelligence'
filtered_gradedata = gradedata[gradedata['curriculum'] == 'Artificial Intelligence']

# Print the shape of filtered gradedata
# print(f'Filtered gradedata shape: {filtered_gradedata.shape}')

# Find unique student IDs in both datasets
unique_blockdata_ids = blockdata['student_id'].unique()
unique_filtered_ids = filtered_gradedata['PEOPLE_ID'].unique()
print(f'Filtered gradedata shape: {unique_blockdata_ids.shape}')
print(f'Filtered gradedata shape: {unique_filtered_ids.shape}')

# Find mismatching IDs:
# IDs in the filtered gradedata but not in blockdata
mismatch_filtered_not_block = filtered_gradedata.loc[~filtered_gradedata['PEOPLE_ID'].isin(unique_blockdata_ids), 'PEOPLE_ID'].unique()

# IDs in blockdata but not in filtered gradedata
mismatch_block_not_filtered = blockdata.loc[~blockdata['student_id'].isin(unique_filtered_ids), 'student_id'].unique()

# Combine both sets of mismatching IDs into one unique set
mismatching_ids = pd.Series(list(set(mismatch_filtered_not_block).union(set(mismatch_filtered_not_block))))

# Save the unique mismatching IDs to a CSV file
output_mismatch_file = 'data/blockdata/unique_mismatching_ids.csv'
mismatching_ids.to_csv(output_mismatch_file, index=False, header=["Mismatching_IDs"])

print(f'Unique mismatching IDs saved to {output_mismatch_file}')
