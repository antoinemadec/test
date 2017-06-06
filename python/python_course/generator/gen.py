#!/usr/bin/env python3

def running_avg():
  avg = 0
  cnt = 0
  while True:
    new_time = yield avg
    cnt +=1
    avg = ((cnt-1) * avg + new_time) / cnt

ra = running_avg()

next(ra)

for t in [60, 58, 62, 60]:
    print("t=%d, avg=%f" % (t, ra.send(t)))
