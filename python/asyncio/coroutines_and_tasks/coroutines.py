#!/usr/bin/env python3

import asyncio
import time

# coroutine
async def main():
    print('hello')
    await asyncio.sleep(1)
    print('world')

# coroutine
async def say_after(delay, what):
    await asyncio.sleep(delay)
    print(what)

# coroutine
async def main_after():
    print(f"started at {time.strftime('%X')}")
    await say_after(1, 'hello')
    await say_after(2, 'world')
    print(f"finished at {time.strftime('%X')}")

# coroutine
async def main_create_task():
    task1 = asyncio.create_task(say_after(1, 'hello'))
    task2 = asyncio.create_task(say_after(2, 'world'))
    print(f"started at {time.strftime('%X')}")
    await task1
    await task2
    print(f"finished at {time.strftime('%X')}")


# Note that simply calling a coroutine will not schedule it to be executed:
# To actually run a coroutine, asyncio provides three main mechanisms:

# 1- The asyncio.run() function to run the top-level entry point “main()” function
asyncio.run(main())


# 2- Awaiting on a coroutine. The following snippet of code will print “hello”
# after waiting for 1 second, and then print “world” after waiting for another
# 2 seconds:
asyncio.run(main_after())


# 3- The asyncio.create_task() function to run coroutines concurrently as asyncio Tasks.
asyncio.run(main_create_task())
