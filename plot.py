import sys
import math
import matplotlib.pyplot as plt

plotMode = sys.argv[1].lower()
if plotMode == 'general':
	try:
		x = [float(j) for j in sys.argv[2].split(",")]
		#print(x)
	except :
		print('Incorrect usage')
	try:
		y = [float(j) for j in sys.argv[3].split(",")]
		#print(y)
	except:
		print('Incorrect Usage')
	plt.plot(x,y)
	#plt.axis('scaled')
	plt.show()
if plotMode == 'circle':
	try:
		r = float(sys.argv[2])
		circle = plt.Circle((0,0), r, fill=False)
		ax = plt.gca()
		ax.add_patch(circle)
		plt.axis('scaled')
		plt.show()
	except:
		print('Incorrect usage')
if plotMode == 'parabola':
	try:
		a = float(sys.argv[2])
		print(a)
		x=[]
		y=[]
		ran=[]
		j=0
		for i in range(100):
			ran.append(j)
			j=j+0.01
		#print(ran)
		for i in ran[::-1]:
			x.append(i)
			y.append(math.sqrt(4*a*i))
		for i in ran:
			x.append(i)
			y.append(-1*math.sqrt(4*a*i))
				
		plt.plot(x,y)
		#plt.axis('scaled')
		plt.show()
	except:
		print('Incorrect usage')
if plotMode == 'ellipse':
	try:
		a = float(sys.argv[2])
		b=float(sys.argv[3])
		print(a,b)
		x=[]
		y=[]
		ran=[]
		j=0
		for i in range(405):
			ran.append(j)
			j=j+(3.14/200)
		#print(ran)
		for i in ran:
			x.append(a*math.sin(i))
			y.append(b*math.cos(i))
		
		plt.plot(x,y)
		plt.axis('scaled')
		plt.show()
	except:
		print('Incorrect usage')
