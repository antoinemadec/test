#!/usr/bin/env python3

import sys
import numpy as np
# http://jakevdp.github.io/blog/2012/08/18/matplotlib-animation-tutorial/
import matplotlib.pyplot as plt
import matplotlib.animation as animation

GRID_SIZE=(500,500)
INIT_SIZE_PCT=70
ROOT_OF_INIT_NB=4


#--------------------------------------------------------------
# functions
#--------------------------------------------------------------
def roll2d(M,x,y):
    r = np.roll
    return r(r(M,x,axis=0),y,axis=1)

def compute_neigh(X):
    neigh = np.zeros(GRID_SIZE)
    for k in range(-1,2):
        for l in range(-1,2):
            if (k,l) != (0,0):
                neigh += roll2d(X,k,l)
    return neigh

def evolve(X, n=1):
    """ return evolved matrix following those rules:
        Overpopulation:  if a living cell is surrounded by more than three living cells, it dies.
        Stasis:          if a living cell is surrounded by two or three living cells, it survives.
        Underpopulation: if a living cell is surrounded by fewer than two living cells, it dies.
        Reproduction:    if a dead cell is surrounded by exactly three cells, it becomes a live cell.
    args:
        X   : matrix of int, either 1 (living cell) or 0 (no/dead cell) to be evolved
        n   : number of evolution steps
    """
    for i in range(0,n):
        neighbors_sum = compute_neigh(X)
        X = np.logical_or(neighbors_sum==3,np.logical_and(X==1,neighbors_sum==2))
    return X

def play(X):
    fig = plt.figure()
    ax  = fig.add_subplot(111)
    ax.get_xaxis().set_visible(False)
    ax.get_yaxis().set_visible(False)
    cnt = ax.text(0.01, 0.99, str(0),color='red', fontsize=30,
            verticalalignment='top', horizontalalignment='left',
            transform=ax.transAxes)
    im  = ax.imshow(X, cmap="gray_r")

    def animate(i):
        X = im.get_array()
        im.set_array(evolve(X))
        cnt.set_text(str(i))
        return im, cnt
    anim = animation.FuncAnimation(fig, animate, frames=None, interval=1, blit=True, repeat=False)
    # anim.save('basic_animation.mp4', fps=30, extra_args=['-vcodec', 'libx264'])
    plt.show()
#--------------------------------------------------------------


#--------------------------------------------------------------
# execution
#--------------------------------------------------------------
X                 = np.zeros(GRID_SIZE, dtype=bool)
x_half_step       = int(GRID_SIZE[0] / ROOT_OF_INIT_NB) >> 1
y_half_step       = int(GRID_SIZE[1] / ROOT_OF_INIT_NB) >> 1
x_half_block_size = int(x_half_step*INIT_SIZE_PCT/100)
y_half_block_size = int(y_half_step*INIT_SIZE_PCT/100)
for x in range(0, GRID_SIZE[0]-x_half_step-x_half_block_size+1, x_half_step<<1):
    for y in range(0, GRID_SIZE[1]-y_half_step-y_half_block_size+1, y_half_step<<1):
        X[x + x_half_step - x_half_block_size : x + x_half_step + x_half_block_size,
                y + y_half_step - y_half_block_size : y + y_half_step + y_half_block_size] = np.random.random((x_half_block_size<<1,y_half_block_size<<1)) < 0.5

play(X)
#--------------------------------------------------------------
