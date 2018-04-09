import sys
import matplotlib.pyplot as plt

plotMode = sys.argv[1].lower()
if plotMode == 'general':
	try:
		x = [int(j) for j in sys.argv[2].split(",")]
		print(x)
	except :
		print('Incorrect usage')
	try:
		y = [int(j) for j in sys.argv[3].split(",")]
		print(y)
	except:
		print('Incorrect Usage')
	plt.plot(x,y)
	plt.show()
if plotMode == 'circle':
	try:
		r = int(sys.argv[2])
		circle = plt.Circle((0,0), r, fill=False)
		ax = plt.gca()
		ax.add_patch(circle)
		plt.axis('scaled')
		plt.show()
	except:
		print('Incorrect usage')
