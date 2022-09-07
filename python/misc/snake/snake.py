#!/usr/bin/env python3

import os
import queue
import random
import sys
import time

from pynput import keyboard


class bcolors:
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKCYAN = '\033[96m'
    OKGREEN = '\033[92m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'


class Snake:
    """Snake game class"""

    def __init__(self, grid_size=20):
        self.grid_size = grid_size
        x = self.grid_size//2
        self.snake_coords = [(x, x-1), (x, x), (x, x+1)]
        self.set_new_fruit()

    def coord_is_wall(self, coord):
        return coord[0] == 0 or coord[1] == 0 or coord[0] == self.grid_size-1 or coord[1] == self.grid_size-1

    def set_new_fruit(self):
        self.fruit_coords = self.snake_coords[-1]
        while self.fruit_coords in self.snake_coords:
            x = random.randrange(1, self.grid_size-1)
            y = random.randrange(1, self.grid_size-1)
            self.fruit_coords = (x, y)

    def process_next_state(self, direction):
        if direction == "right":
            d = (0, 1)
        elif direction == "left":
            d = (0, -1)
        elif direction == "up":
            d = (-1, 0)
        elif direction == "down":
            d = (1, 0)
        else:
            raise ValueError("direction must be in right/left/up/down")

        # compute new head
        head = self.snake_coords[-1]
        new_head = (head[0] + d[0], head[1] + d[1])
        if new_head in self.snake_coords or self.coord_is_wall(new_head):
            print("YOU LOOSE")
            sys.exit(1)

        # update snake
        self.snake_coords += [new_head]
        if new_head != self.fruit_coords:
            self.snake_coords = self.snake_coords[1:-1] + [new_head]
        else:
            self.set_new_fruit()

    def print_grid(self):
        # put cursor back to upper left corner
        os.system("tput cup 0 0")

        string = ""
        for x in range(self.grid_size):
            for y in range(self.grid_size):
                if x == 0 or x == self.grid_size-1:
                    string += bcolors.FAIL + "_"
                elif y == 0 or y == self.grid_size-1:
                    string += bcolors.FAIL + "|"
                elif (x, y) in self.snake_coords:
                    if (x, y) == self.snake_coords[-1]:
                        string += bcolors.WARNING + "@"
                    else:
                        string += bcolors.WARNING + "*"
                elif (x, y) == self.fruit_coords:
                    string += bcolors.OKGREEN + "O"
                else:
                    string += " "
            string += "\n" + bcolors.ENDC
        print(string)
        print(f"size = {len(self.snake_coords)}")


if __name__ == "__main__":
    keys_q = queue.Queue(maxsize=3)
    keys_q.put("right")

    def on_press(key):
        global keys_q
        if key == keyboard.Key.right:
            keys_q.put("right")
        elif key == keyboard.Key.left:
            keys_q.put("left")
        elif key == keyboard.Key.up:
            keys_q.put("up")
        elif key == keyboard.Key.down:
            keys_q.put("down")

    listener = keyboard.Listener(on_press=on_press)
    listener.start()

    s = Snake()
    while True:
        s.print_grid()
        time.sleep(0.2)
        direction = keys_q.get()
        if keys_q.empty():
            keys_q.put(direction)
        s.process_next_state(direction)
