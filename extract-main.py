import os
import json
import random
import csv
import ast

# UPDATE ELEMENTS BELOW ACCORDINGLY
# sequence=['vcm'] #['vcm','ppm']

# for treatment in sequence:

# extract CSV file and store in data_list
data_list = []

os.chdir('E:/OneDrive - The University of Melbourne/Nguyên/UniMel/Attempt/Prof.Nisvan/Milestones - Endogenous choice/Data/STATA')
with open('extract_python.csv', newline='') as csvfile:
	my_list = csv.reader(csvfile, delimiter=',')
	for row in my_list:
		data_list.append(row)
		
# extract variable names and store in var_names
var_names = []

x = data_list[1][1]
x = json.loads(x)
#print(x)

for key in x:
	var_names.append(str(key))
var_names.append(data_list[0][0]) # player ID in session
var_names.append(data_list[0][2]) # VCM treatment
var_names.append(data_list[0][3]) # interval treatment
var_names.append(data_list[0][4]) # dropout variable
var_names.append(data_list[0][5]) # session code
var_names.append(data_list[0][6]) # session label
#print(var_names)
	
# write new CSV
os.chdir('E:/OneDrive - The University of Melbourne/Nguyên/UniMel/Attempt/Prof.Nisvan/Milestones - Endogenous choice/Data/STATA/Data')

with open('merged-main.csv', 'w', newline='') as csvfile:
	mywriter = csv.writer(csvfile, delimiter=',',)
	
	# var_names in first row
	mywriter.writerow(var_names)
	
	# each element of data_list in subsequent rows
	for i in range(1,len(data_list)):
		x = json.loads(data_list[i][1])
		
		#print(i)
		#print(x)
		row = []
		for key in x:
			row.append(x[key])
		row.append(data_list[i][0]) # player ID in session
		row.append(data_list[i][2]) # VCM treatment
		row.append(data_list[i][3]) # interval treatment
		row.append(data_list[i][4]) # dropout variable
		row.append(data_list[i][5]) # session code
		row.append(data_list[i][6]) # session label
		mywriter.writerow(row)