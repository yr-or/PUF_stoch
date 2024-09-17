"""
For comparing outputs of PUF randomness
"""

import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
from sklearn.metrics import mean_squared_error
import os

############### Read ILA data ################
# PUF_2_randbit_test1
# PUF_2_feedback_randbit_test1
# PUF_4_randbit_test1
# LFSR8_Gal_rand_bit_test1
# RO_PUF_5_randbit_test1
# LFSR8_Fib_randbit_test1

testname = "PUF_4_randbit_test1"

file1 = "C:\\Users\\Rory\\Documents\\HDL\\PUF_Stoch\\Outputs\\" + testname + ".csv"

df1 = pd.read_csv(file1)

# Delete row 2 and rewrite to file
if "UNSIGNED" in df1.iloc[0].values:
    df2 = df1.drop(index=0).reset_index(drop=True)
    df2.to_csv(file1, index=False)
######### 

df = pd.read_csv(file1)

# Set start and end range
data = df.iloc[:, 3:]

data_str_arr = []


## row-wise pack
for i, row in data.iterrows():
    vals = row.values
    row_str = ''.join(vals.astype(str))
    data_str_arr.append(row_str)

"""   
## Column wise pack into 8-bits
rand_int8_arr = []
for col in data.columns:
    vals = data[col].values
    col_str = ''.join(vals.astype(str))
    data_str_arr.append(col_str)
"""

########### Write to binary file #########
if not os.path.exists(file1):
    with open( (testname + ".e"), "w+") as f:
        for row in data_str_arr:
            f.write(row)


########## Plot the distribution of 8-bit values ##########
rand_int8_arr = []
for row in data_str_arr:
    for i in range(0,200,8):
        val = int(row[i:i+8], 2)
        rand_int8_arr.append(val)

        
   
bins = [i for i in range(0,255,16)]
bins.append(256)

plt.figure(1)
plt.hist(rand_int8_arr, bins=bins, color='tab:blue', edgecolor='black')
plt.xticks(bins)
plt.title("Random Number distribution PUF_RNG_4")
plt.xlabel("Values")
plt.ylabel("No. of occurances")
plt.show()

########### Plot the space-time diagram ############
plt.figure(2)
plt.imshow(data, cmap='gray', interpolation='none')
plt.axis('off')


######### Get the autocorrelation of 8-bit values #########
stream = rand_int8_arr

# Step 3: Mean-center the data (remove the mean)
mean_centered_stream = stream - np.mean(stream)

# Step 4: Compute the autocorrelation using NumPy's correlate function
autocorrelation = np.correlate(mean_centered_stream, mean_centered_stream, mode='full')

# Normalize the autocorrelation
autocorrelation = autocorrelation / autocorrelation.max()

# Step 5: Take the second half of the correlation (positive lags only)
lags = np.arange(len(autocorrelation)//2)
autocorrelation = autocorrelation[(len(autocorrelation)//2)+1:]

# Step 6: Plot the autocorrelation
plt.figure(figsize=(10, 5))
plt.plot(lags, autocorrelation)
plt.title('Autocorrelation of 8-bit Stream')
plt.xlabel('Lag')
plt.ylabel('Autocorrelation')
plt.grid(True)

plt.show()