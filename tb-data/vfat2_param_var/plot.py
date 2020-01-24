import sys, os  
import matplotlib.pyplot as plt

dataX = []
dataY = []

for fn in os.listdir(sys.argv[1]):
	i = 0
	x = []
	y = []
	with open(sys.argv[1] + "/" + fn, "r") as f:
    		for line in f:
			if (i < 5): 
				i += 1
				continue        		
			value = int(line) 
			if (value < 0): value += 2**32
			x.append(value >> 24)
			y.append(value & 0xffffff)
	dataX.append(x)
	dataY.append(y)

plt.plot(
dataX[0], dataY[0], "b", 
dataX[1], dataY[1], "g", 
dataX[2], dataY[2], "r", 
dataX[3], dataY[3], "c", 
dataX[4], dataY[4], "m", 
dataX[5], dataY[5], "y", 
dataX[6], dataY[6], "k", 
dataX[7], dataY[7], "b-", 
dataX[8], dataY[8], "g-", 
dataX[9], dataY[9], "r-", 
dataX[10], dataY[10], "c-", 
dataX[11], dataY[11], "m-",
dataX[12], dataY[12], "y-",
dataX[13], dataY[13], "k-", 
dataX[14], dataY[14], "b:", 
dataX[15], dataY[15], "g:", 
dataX[16], dataY[16], "r:", 
dataX[17], dataY[17], "c:", 
dataX[18], dataY[18], "m:", 
dataX[19], dataY[19], "y:", 
dataX[20], dataY[20], "k:", 
dataX[21], dataY[21], "b" 
)
plt.show()
