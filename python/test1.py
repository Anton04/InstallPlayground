import math, csv, time, datetime
import matplotlib.pyplot

avg = 0
dev = 0
devdev = 0

AVGLEN = 10.0

avgarr = []
devarr = []
indexarr = []
samplearr = []
diffarr = []

def process_sample(x):
  global avg, dev, devdev
  print "Processing ", x
  avg = (avg * (AVGLEN - 1.0) + x) / AVGLEN
  dev = (dev * 9.0 + abs(x - avg)) / 10.0
  avgarr.append(avg)
  devarr.append(dev)
  if avg < 1.0:
    fact = 0.5
  else:
    fact = avg
  diffarr.append(abs(x - avg) / fact)

def process_data(data):
  for sample in data:
    process_sample(sample)

def generate_data():
  for x in range(1000):
    sample = math.sin(x / 10.0)
    sq = 0
    if sample > 0: sq = 200
    sample = sample * 100 + 100
    indexarr.append(x)
    if x > 800: sample = 150
    samplearr.append(sample)

def annotate_trigger(ax, pos, data, txt):
  ax.annotate(txt, xy=(indexarr[pos], data[pos]),  xycoords='data',
              xytext=(50, 30), textcoords='offset points',
              arrowprops=dict(arrowstyle="->"))


# Check
with open('datasets/Washingmachine.csv', 'rb') as csvfile:
  reader = csv.reader(csvfile, delimiter=';', quotechar='|')
  print reader.next()
  for row in reader:
    if row[0]=="Power":
      print row[1],row[2]
      ts = time.strptime(row[1], "%Y-%m-%dT%H:%M:%S.000Z")
      #    print ts, time.mktime(ts)
      indexarr.append(time.mktime(ts))
      samplearr.append(float(row[2]))

#generate_data()
process_data(samplearr)
fig = matplotlib.pyplot.figure(1)
ax = fig.add_subplot(111)

ax.plot(indexarr, samplearr)
ax.plot(indexarr, avgarr)
ax.plot(indexarr, devarr)
ax.plot(indexarr, diffarr)

annotate_trigger(ax, 147, diffarr, "Energy up!")
matplotlib.pyplot.show()
