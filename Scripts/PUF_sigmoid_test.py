"""
For comparing outputs of PUF to sigmoid
"""

import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
from sklearn.metrics import mean_squared_error, mean_absolute_error

############### Read ILA data ################
# PUF_sigmoid_test2:            RO_PUF_4 with sigmoid FSM

file1 = r"C:\Users\Rory\Documents\HDL\PUF_Stoch\Outputs\PUF_feedback_sigmoid_test1.csv"

df1 = pd.read_csv(file1)

# Delete row 2 and rewrite to file
if "UNSIGNED" in df1.iloc[0].values:
    df2 = df1.drop(index=0).reset_index(drop=True)
    df2.to_csv(file1, index=False)
######### 

df = pd.read_csv(file1)

# Set start and end range
row_index_done = (df[df['done[0:0]'] == 1].index)
data = df.iloc[row_index_done, 5:]

## ILA results
#sigmoid_out_int8 = data.loc[:, "sigmoid_out[0][7:0]":"sigmoid_out[199][7:0]"].values.tolist()[0]
sigmoid_out_int8 = [0]*200
for i in range(200):
    ind = f"relu_out[{i}][7:0]"
    sigmoid_out_int8[i] = data.loc[:, ind].values.tolist()[0]


############ Functions #################
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

def int8_to_unipolar(x):
	return x/256

def sigmoid(x):
	return 1 / (1 + np.exp(-4*x))

N = 5
def tanh(x):
     return (np.exp(2*(N/2)*x) - 1) / (np.exp(2*(N/2)*x) + 1)


############ Python data #################
x_values_int8 = [250, 47, 191, 225, 118, 27, 72, 235, 116, 5, 230, 242, 73, 57, 218, 252, 164, 124, 13, 127, 109, 158, 51, 24, 140, 50, 111, 181, 173, 84, 128, 57, 246, 188, 236, 211, 2, 218, 34, 161, 115, 67, 54, 182, 31, 37, 127, 243, 111, 28, 49, 182, 191, 102, 60, 123, 221, 62, 1, 201, 54, 233, 20, 99, 57, 67, 3, 181, 40, 170, 73, 109, 4, 248, 197, 248, 133, 193, 117, 248, 135, 79, 123, 142, 50, 78, 17, 123, 179, 244, 75, 135, 60, 253, 237, 142, 6, 137, 114, 249, 76, 27, 120, 95, 97, 223, 147, 162, 183, 133, 99, 150, 212, 158, 13, 76, 152, 89, 13, 35, 94, 220, 56, 145, 168, 189, 9, 0, 66, 231, 206, 183, 146, 34, 246, 112, 20, 117, 62, 105, 230, 171, 81, 146, 221, 158, 92, 214, 226, 98, 205, 223, 113, 10, 161, 112, 21, 100, 75, 41, 98, 88, 207, 186, 203, 190, 50, 110, 189, 45, 148, 76, 56, 134, 157, 207, 188, 43, 43, 153, 183, 54, 112, 16, 237, 60, 72, 147, 16, 81, 29, 223, 215, 229, 71, 202, 221, 236, 152, 94]

x_values_float = [ prob_int_to_bipolar(x) for x in x_values_int8 ]

############### ILA data #################
sigmoid_out_float = [prob_int_to_bipolar(x) for x in sigmoid_out_int8]


############### Plot results #################
plt.figure(1)
plt.title("Sigmoig test RO_PUF")
plt.scatter(x_values_float, sigmoid_out_float, label="Sigmoid PUF")
plt.grid()
# Plot actual sigmoid
sgm_x_pts = np.linspace(-1,1,200)
sgm_y_pts = tanh(sgm_x_pts)
plt.plot(sgm_x_pts, sgm_y_pts, 'r', label="Sigmoid exact")


################ Get MSE #####################
mse = mean_squared_error(sgm_y_pts, sigmoid_out_float)
print("MSE =", mse)

mae = mean_absolute_error(sgm_y_pts, sigmoid_out_float)
print("MAE =", mae)



plt.show()