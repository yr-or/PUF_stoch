"""
For comparing outputs of PUF randomness
"""

import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
from sklearn.metrics import mean_squared_error

############### Read ILA data ################

file1 = r"C:\Users\Rory\Documents\HDL\RO_PUF\Outputs\iladata_lfsr.csv"

df1 = pd.read_csv(file1)

# Delete row 2 and rewrite to file
if "UNSIGNED" in df1.iloc[0].values:
    df2 = df1.drop(index=0).reset_index(drop=True)
    df2.to_csv(file1, index=False)
######### 

df = pd.read_csv(file1)
