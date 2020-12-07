import numpy as np
import csv
ascii_grid = np.loadtxt("../../Calibration/out/epsilons_beta.asc", skiprows=6)
ascii_grid_p = np.loadtxt("../../GIS/rwa_init_pop.asc", skiprows=6)
ascii_grid_pfpr = np.loadtxt("../../GIS/rwa_pfpr2to10.asc", skiprows=6)
print("Epsilon,  population,  pfpr")
fields = ['Epsilon','population', 'pfpr']
rows =[]
for i in range(0,len(ascii_grid)):
  for n in range(0,len(ascii_grid[i])):
    if ascii_grid[i][n] >= 0.015:
      rows.append([ascii_grid[i][n],ascii_grid_p[i][n],ascii_grid_pfpr[i][n]])
      print("{0:.5f}  ".format(ascii_grid[i][n]), "{0:10.0f}  ".format(ascii_grid_p[i][n]),   ascii_grid_pfpr[i][n])
print(rows)
filename = 'epsilonPfpr.csv'
with open(filename, 'w',newline='') as csvfile:
    csvwriter = csv.writer(csvfile)      
    # writing the fields  
    csvwriter.writerow(fields)
    # writing the data rows  
    csvwriter.writerows(rows) 