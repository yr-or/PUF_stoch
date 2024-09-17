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
    
    
########## Run LFSRs with different seeds ############
random.seed(14)

corr_arr = []
corr_seed1 = []
corr_seed2 = []
num_corr_seeds = []

#for k in range(10):
#    val1 = random.randint(50,255)
#    val2 = random.randint(50,255)
for seed1 in range(1, 255):
    for seed2 in range(seed1+1, 255):
#for i in range(200):
        #seed1 = random.randint(1, 128)
        #seed2 = random.randint(1, 128)
        #while seed2 == seed1:
        #    seed2 = random.randint(1, 255)
    
        num1_bs = []
        num2_bs = []
        
        lfsr1 = LFSR_Fib(seed1, taps=[2,3,4])
        lfsr2 = LFSR_Fib(seed2, taps=[2,3,4])
        
        
        num1_bs = gen_stoch_num(lfsr1, 64)
        num2_bs = gen_stoch_num(lfsr2, 192)
            
    
        ## Get SCC
        corr = SCC(num1_bs, num2_bs)
        corr_arr.append(corr)
        
        if (np.abs(corr) > 0.9):
            corr_seed1.append(seed1)
            corr_seed2.append(seed2)
    #num_corr_seeds.append(len(corr_seed1))
    
#print(num_corr_seeds)
#print(sum(num_corr_seeds))

print(len(corr_seed1))

plt.figure(figsize=(10,6))
plt.title("Correlation for 200 randomly seeded SNGs")
x_vals = [x for x in range(len(corr_arr))]
plt.plot(x_vals, corr_arr)
plt.ylabel("SCC")
plt.xlabel("Test no.")
plt.grid()

plt.figure(figsize=(10,10))
plt.title("Highly correlated LFSR seed values")
plt.scatter(corr_seed1, corr_seed2)
plt.grid()
plt.xlabel("Seed 1")
plt.ylabel("Seed 2")


plt.show()


    

    
    
    
    
    
    
    
    