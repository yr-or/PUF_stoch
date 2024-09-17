import matplotlib.pyplot as plt
import random
import numpy as np

class LFSR_Fib():
    def __init__(self, seed, taps):
        self.state = seed
        self.taps = taps
        
    def step(self):        
        # Get 0 bit
        new_bit = ((self.state << 7) >> 7) & 1
        for tap in self.taps:
            new_bit ^= (self.state >> tap) & 1

        # Shift the register to the right and insert the new bit on the left
        
        self.state = (self.state >> 1) | (new_bit << 7)
        
        # Return the current state
        self.state
        return self.state
    

def gen_stoch_num(lfsr, num):
    bitstream = []
    for i in range(255):
        rand = lfsr.step()
        #rand = random.randint(1,255)
        if (rand <= num):
            bitstream.append(1)
        else:
            bitstream.append(0)
    return bitstream


def SCC(arr1, arr2):
    px = sum(arr1)/255
    py = sum(arr2)/255
    pxy = px*py
    arr_and = [arr1[i] & arr2[i] for i in range(255)]
    px_and_y = sum(arr_and)/255
    if (px_and_y > pxy):
        corr = (px_and_y-pxy)/(min(px, py)-pxy)
    else:
        num = (px_and_y-pxy)
        den = (pxy - max(px+py-1, 0))
        if (den <= 0):
            print(den)
        corr = num/den
    return corr
    
    
########## Run LFSR ############
rand_arr = []
lfsr = LFSR_Fib(121, taps=[2,3,4])

for i in range(1024):
    rand_arr.append(lfsr.step())


####### Plot LFSR vals #########
plt.figure(1)
xvals = [i for i in range(1024)]
plt.plot(xvals, rand_arr)



######### Get the autocorrelation of 8-bit values #########
stream = rand_arr

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
plt.figure(2)
plt.figure(figsize=(10, 5))
plt.plot(lags, autocorrelation)
plt.title('Autocorrelation of 8-bit LFSR stream')
plt.xlabel('Lag')
plt.ylabel('Autocorrelation')
plt.grid(True)

plt.show()