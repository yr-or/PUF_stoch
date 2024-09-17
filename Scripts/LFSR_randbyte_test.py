"""
For comparing outputs of LFSRs
"""

import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
from sklearn.metrics import mean_squared_error
import os

############### Read ILA data ################
# LFSR8_Fib_randbyte_test1
# PUF_4_randbyte_test1
# LFSR8_Galois_randbyte_test1
# PUF_2_randbyte_test1
# PUF_2_feedback_randbyte_test1

testname = "LFSR8_Fib_randbyte_test1"

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

lfsrs_8bit_arr = []


## Column wise pack into 8-bits
for col in data.columns:
    rand_int8_arr = []
    vals = data[col].values
    rand_int8_arr = [int(val) for val in vals]
    lfsrs_8bit_arr.append(rand_int8_arr)



########## Plot the distribution of 8-bit values ##########
lfsr_data = lfsrs_8bit_arr[0]

bins = [i for i in range(0,255,16)]
bins.append(256)

plt.figure(1)
plt.hist(lfsr_data, bins=bins, color='tab:blue', edgecolor='black')
plt.xticks(bins)
plt.title("Random Number distribution")
plt.xlabel("Values")
plt.ylabel("No. values")


######### Get the autocorrelation of 8-bit values #########
stream = lfsr_data

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