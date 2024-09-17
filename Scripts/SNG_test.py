import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
from sklearn.metrics import mean_squared_error

############### Read ILA data ################
# LFSR_SNG_test1

testname = "LFSR_SNG_test1"

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

for i, row in data.iterrows():
    vals = row.values
    row_str = ''.join(vals.astype(str))
    data_str_arr.append(row_str)

########## Test correlation ##########
def int8_to_unipolar(x):
    return x/256

test_vals = [124, 252, 25, 99, 238, 250, 61, 22, 31, 14, 97, 30, 111, 114, 4, 222, 155, 4, 172, 180, 152, 193, 155, 33, 139, 143, 188, 209, 202, 254, 220, 37, 43, 63, 158, 223, 132, 26, 107, 203, 201, 167, 234, 17, 213, 129, 81, 88, 81, 64, 17, 162, 72, 149, 230, 153, 250, 19, 179, 182, 11, 223, 45, 169, 42, 182, 252, 3, 212, 65, 175, 224, 43, 169, 133, 59, 59, 66, 111, 201, 53, 36, 7, 114, 94, 139, 117, 148, 208, 119, 50, 175, 178, 29, 17, 63, 247, 35, 207, 110]







######### Autocorrelation ############
"""
def sum_sn(arr):
    sum = 0
    for bit in arr:
        sum += int(bit)
    return sum

exp_probs = [int8_to_unipolar(x) for x in test_vals]

## SN 0
SN0 = data_str_arr[0]

N = 1024
Ak = []

for k in range(N):
    num = 0
    den = 0
    for i in range(1, N):
        Yi =  sum_sn(SN0[0:i]) / i
        Yipk = sum_sn(SN0[0:i+k]) / i
        Y = exp_probs[0]
        num += (Yi-Y)*(Yipk-Y)
        den += (Yi-Y)**2
    Ak.append(num/den)

    
## Plot Ak
x_vals = [i for i in range(N)]
plt.plot(x_vals, Ak)

plt.show()
"""


