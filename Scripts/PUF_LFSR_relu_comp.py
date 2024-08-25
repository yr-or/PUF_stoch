"""
For comparing outputs implemented PUF and LFSR ReLU FSMs
"""

import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
from sklearn.metrics import mean_squared_error

############### Read ILA data from impl Layer2 ################
file1 = r"C:\Users\Rory\Documents\HDL\PUF_stoch\Outputs\PUF_LFSR_relu_comp_test1.csv"

df1 = pd.read_csv(file1)

# Delete row 2 and rewrite to file
if "UNSIGNED" in df1.iloc[0].values:
    df2 = df1.drop(index=0).reset_index(drop=True)
    df2.to_csv(file1, index=False)
######### 


df = pd.read_csv(file1)

# Set start and end range
row_index_done = (df[df['done'] == 1].index)
data = df.iloc[row_index_done, 5:]

## ILA results - PUF and LFSR arrays
relu_puf_int8 = data.loc[:, "out_val_puf[0][7:0]":"out_val_puf[99][7:0]"].values.tolist()[0]
relu_lfsr_int8 = data.loc[:, "out_val_lfsr[0][7:0]":"out_val_lfsr[99][7:0]"].values.tolist()[0]

############# Debug ##################
assert(len(relu_puf_int8) == len(relu_lfsr_int8))

############ Plot Results #################
def bipolar_to_prob(y):
    return (y+1)/2

def bipolar_to_prob_int(y):
    return int(bipolar_to_prob(y)*256)

def prob_to_bipolar(x):
    return (2*x)-1

def prob_int_to_bipolar(x):
    return prob_to_bipolar(x/256)

def prob_int16_to_bipolar(x):
    return prob_to_bipolar(x/65536)

def unipolar_to_int8(x):
	return int(x*256)

def int8_to_unipolar(x):
	return x/256

# Convert vivado values to floats
relu_puf_float = [int8_to_unipolar(x) for x in relu_puf_int8]
relu_lfsr_float = [int8_to_unipolar(x) for x in relu_lfsr_int8]

x_values_int8 = [11, 120, 148, 9, 82, 203, 89, 167, 227, 3, 161, 251, 195, 15, 93, 173, 247, 146, 59, 92, 127, 18, 169, 130, 39, 225, 34, 212, 125, 201, 96, 151, 88, 45, 35, 65, 120, 71, 183, 119, 58, 24, 12, 183, 87, 173, 227, 222, 43, 42, 229, 220, 149, 65, 239, 141, 135, 185, 44, 89, 105, 76, 129, 142, 89, 148, 74, 59, 9, 227, 56, 18, 168, 34, 249, 8, 55, 140, 176, 74, 206, 6, 110, 3, 39, 79, 65, 197, 49, 177, 76, 222, 116, 36, 236, 90, 39, 109, 133, 233]
x_values_float = [prob_int_to_bipolar(x) for x in x_values_int8]

####### Plot and compare outputs ########

## PUF
plt.figure(1)
x_values = [i for i in range(len(relu_puf_float))]
plt.title("PUF relu")
plt.scatter(x_values_float, relu_puf_float, label="PUF relu values")
plt.legend()
plt.grid()
# Plot actual relu
relu_x_pts = np.linspace(-1, 1, 100)
relu_y_pts = [0]*50 + list(np.linspace(0,1,50))
plt.plot(relu_x_pts, relu_y_pts, 'r', label="ReLU exact")

## LFSR
plt.figure(2)
x_values = [i for i in range(len(relu_lfsr_float))]
plt.title("LFSR relu")
plt.scatter(x_values_float, relu_lfsr_float, label="LFSR relu values")
plt.legend()
plt.grid()
# Plot actual relu
relu_x_pts = np.linspace(-1, 1, 100)
relu_y_pts = [0]*50 + list(np.linspace(0,1,50))
plt.plot(relu_x_pts, relu_y_pts, 'r', label="ReLU exact")


################ Get MSE #####################
mse_puf = mean_squared_error(relu_y_pts, relu_puf_float)
print("MSE PUF=", mse_puf)

mse_lfsr = mean_squared_error(relu_y_pts, relu_lfsr_float)
print("MSE LFSR=", mse_lfsr)


plt.show()