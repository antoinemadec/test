#!/usr/bin/env python3

import lockfile
import time

lock = lockfile.LockFile("./foo")

while not lock.i_am_locking():
    try:
        lock.acquire(timeout=120)    # wait up to 2min
    except lockfile.LockTimeout:
        lock.break_lock()
        lock.acquire()

print("lock " + lock.path)
time.sleep(5)
lock.release()
print("unlock " + lock.path)
