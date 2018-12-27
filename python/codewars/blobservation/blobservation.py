#!/usr/bin/env python3

'''
Blobs of various sizes are situated in a room. Each blob will move toward the
nearest smaller blob until it reaches it and engulfs it. After consumption, the
larger blob grows in size.

Your task is to create a class Blobservation (a portmanteau of blob and
observation) and methods that give information about each blob after an
arbitrary number of moves.

Class Details

A Blobservation class instance is instantiated with two integer values, h and
w, that represent the dimensions of the room. The instance methods are as
follows:

populate
    Each element is an object/dict/Map<String,Integer> with the following properties:
        x: vertical position
        y: horizontal position
        size: size of the blob
    This method may be called multiple times on the same class instance
    If a new blob's position is already occupied by an existing blob, the two fuse into a single blob
    If the list input contains any invalid values, discard it entirely and
    throw an error (do not update/modify the instance)

move
    The move method may be called with up to one argument — a positive integer
    representing the number of move iterations (ie. turns) to process. If no
    argument is given, the integer value defaults to 1.

print_state
    The print_state/printState method is a nullary function that returns an
    array/List<List<Integer>> of the positions and sizes of each blob at the
    current state, sorted in ascending order by x position, then by y. If there are
    no blobs, return an empty array.

Blob Movement Behavior

With each turn, every blob whose size is larger than the smallest blob size
value will move to one of the 8 spaces immediately surrounding it (Moore
neighborhood) in the direction of the nearest target blob with a lower relative
size.

    If a target's coordinates differ on both axes, the predatory blob will move
    diagonally. Otherwise, it will move in the cardinal direction of its target

    If multiple targets are at the same movement distance, the blob with the
    largest size is focused

    If there are multiple targets that have both the largest size and shortest
    movement distance, priority is set in clockwise rotation, starting from the
    12 position

    If two blobs pass each other (e.g. swap positions as a result of their
    movement), they will not fuse

    Blobs of the smallest size remain stationary

Additional Technical Details

    A blob's initial size will range between 1 and 20
    Multiple blobs occupying the same space will automatically fuse into one
    When a blob consumes another blob, or when two blobs fuse, the remaining blob's size becomes the sum of the two
    The 2nd argument for the class constructor is optional; if omitted, the room defaults to a square, where w == h.
    Room dimensions (h and w) will range between 8 and 50
    Class instances will always be instantiated with valid arguments
    Methods should throw an error if called with invalid arguments
    Boolean values are not to be regarded as valid integers (Java: check for null is needed instead)
'''

class Blobservation:
    def __init__(self,h,w=None):
        if not w:
            w = h
        self.w,self.h = w,h
        self.max = max(w,h)
        self.blobs = {}

    def populate(self,l):
        bak = self.blobs.copy()
        for d in l:
            if type(d) != dict or 'size' not in d or 'x' not in d or 'y' not in d \
                    or type(d['size']) != int or d['size']<1 or d['size']>20 \
                    or type(d['x']) != int or d['x']<0 or d['x']>self.h \
                    or type(d['y']) != int or d['y']<0 or d['y']>self.w:
                self.blobs = bak
                raise ValueError('out of range')
            x,y = d['x'],d['y']
            self.blobs[(x,y)] = self.blobs.get((x,y),0) + d['size']

    def move(self,n=1):
        if type(n) != int or n<1:
            raise ValueError('no negative value allowed')
        for _ in range(n):
            new_blobs = {}
            blob_list = [(*k,v) for k,v in sorted(self.blobs.items(), key=lambda x:x[1])]
            for x,y,s in blob_list:
                if s == blob_list[0][2]:
                    new_blobs[(x,y)] = s
                else:
                    # find closest lower neighbor with self.blobs
                    for d in range(1,self.max):
                        neighbors = [(c[0],c[1],self.blobs[c]) for c in perimeter((x,y),d) \
                                if c in self.blobs]
                        neighbors = [e for e in neighbors if e[2]<s]
                        if neighbors:
                            max_size = max(neighbors, key=lambda x:x[2])[2]
                            neighbors = [e for e in neighbors if e[2]==max_size]
                            neighbor = neighbors[0]
                            break
                    # move
                    dire = direction((x,y),neighbors[0])
                    k,l = x+dire[0],y+dire[1]
                    new_blobs[(k,l)] = new_blobs.get((k,l),0) + s
            self.blobs = new_blobs

    def print_state(self):
        return [[x,y,self.blobs[(x,y)]] for x in range(self.h) for y in range(self.w) \
                if (x,y) in self.blobs]


def perimeter(c,d):
    a = []
    x = c[0] - d
    for y in range(c[1],c[1]+d+1):
        a.append((x,y))
    for x in range(c[0]-d+1,c[0]+d+1):
        a.append((x,y))
    for y in range(c[1]+d-1,c[1]-d-1,-1):
        a.append((x,y))
    for x in range(c[0]+d-1,c[0]-d-1,-1):
        a.append((x,y))
    for y in range(c[1]-d+1,c[1]):
        a.append((x,y))
    return a

def direction(c0,c1):
    c = [c1[0]-c0[0],c1[1]-c0[1]]
    for i,x in enumerate(c):
        if x < 0:   c[i] = -1
        elif x > 0: c[i] = 1
        else: c[i] = 0
    return c


#--------------------------------------------------------------
# testing
#--------------------------------------------------------------
generation0 = [
	{'x':0,'y':4,'size':3},
	{'x':0,'y':7,'size':5},
	{'x':2,'y':0,'size':2},
	{'x':3,'y':7,'size':2},
	{'x':4,'y':3,'size':4},
	{'x':5,'y':6,'size':2},
	{'x':6,'y':7,'size':1},
	{'x':7,'y':0,'size':3},
	{'x':7,'y':2,'size':1}]
blobs = Blobservation(8)
blobs.populate(generation0)
# print(blobs.print_state())
blobs.move()
# print(blobs.print_state())
# print([[0,6,5],[1,5,3],[3,1,2],[4,7,2],[5,2,4],[6,7,3],[7,1,3],[7,2,1]])
blobs.move()
# print(blobs.print_state())
# print([[1,5,5],[2,6,3],[4,2,2],[5,6,2],[5,7,3],[6,1,4],[7,2,4]])
blobs.move(1000)
# print(blobs.print_state(),[[4,3,23]])

generation1 = [
	{'x':3,'y':6,'size':3},
	{'x':8,'y':0,'size':2},
	{'x':5,'y':3,'size':6},
	{'x':1,'y':1,'size':1},
	{'x':2,'y':6,'size':2},
	{'x':1,'y':5,'size':4},
	{'x':7,'y':7,'size':1},
	{'x':9,'y':6,'size':3},
	{'x':8,'y':3,'size':4},
	{'x':5,'y':6,'size':3},
	{'x':0,'y':6,'size':1},
	{'x':3,'y':2,'size':5}]
generation2 = [
	{'x':5,'y':4,'size':3},
	{'x':8,'y':6,'size':15},
	{'x':1,'y':4,'size':4},
	{'x':2,'y':7,'size':9},
	{'x':9,'y':0,'size':10},
	{'x':3,'y':5,'size':4},
	{'x':7,'y':2,'size':6},
	{'x':3,'y':3,'size':2}]
blobs = Blobservation(10,8)
# print(blobs.print_state())
blobs.populate(generation1)
# print(blobs.print_state())
blobs.move()
# print(blobs.print_state())
# print([[0,6,1],[1,1,1],[1,6,2],[2,1,5],[2,6,7],[4,2,6],[6,7,3],[7,1,2],[7,4,4],[7,7,1],[8,7,3]])
blobs.move(2)
# print(blobs.print_state())
# print([[0,6,7],[1,5,3],[2,2,6],[4,1,6],[6,1,2],[6,4,4],[6,6,7]])
blobs.move(2)
# print(blobs.print_state())
# print([[2,4,13],[3,3,3],[6,1,8],[6,2,4],[6,4,7]])
blobs.populate(generation2)
# print(blobs.print_state())
# print([[1,4,4],[2,4,13],[2,7,9],[3,3,5],[3,5,4],[5,4,3],[6,1,8],[6,2,4],[6,4,7],[7,2,6],[8,6,15],[9,0,10]])
blobs.move()
# print(blobs.print_state(),[[2,4,9],[3,3,13],[3,6,9],[4,4,4],[5,3,4],[5,4,10],[6,2,6],[7,2,8],[7,5,15],[8,1,10]])
blobs.move(3)
print(blobs.print_state())
# print([[4,3,22],[5,3,28],[5,4,9],[6,2,29]])

# ERRORS
# test.expect_error('Invalid input for the move method should trigger an error',lambda: blobs.move(-3))
# blobs.move(-3)
blobs.move(30)
print(blobs.print_state(),[[5,3,88]])
# test.expect_error('Invalid elements should trigger an error',lambda: blobs.populate([{'x':4,'y':6,'size':3},{'x':'3','y':2,'size':True}]))
# blobs.populate([{'x':4,'y':6,'size':3},{'x':'3','y':2,'size':True}])
# # print('<COMPLETEDIN::>')
