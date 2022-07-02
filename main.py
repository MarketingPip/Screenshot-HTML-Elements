# Define the filename here you want to replace content in
FileName = "README2.md"

contents= "test"
with open(FileName, 'w') as f:
    f.write(contents)   
