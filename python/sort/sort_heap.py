import random

def swap(mas, i1, i2):
    temp = mas[i1]
    mas[i1] = mas[i2]
    mas[i2] = temp


def sort_heap(mas):
    hsize = len(mas)
    build_maxheap(mas, hsize)

    while hsize > 1:
        swap(mas, 0, hsize-1)
        hsize -= 1
        maxheapify(mas, hsize, 0)


def heap_parent(i):
    return (i >> 1)

def heap_right(i):
    return (i << 1) | 1

def heap_left(i):
    return (i << 1)


def maxheapify(mas, hsize, i):
    iright = heap_right(i)
    ileft = heap_left(i)

    imax = i
    if iright < hsize and  mas[iright] > mas[imax]:
        imax = iright
    if ileft < hsize and mas[ileft] > mas[imax]:
        imax = ileft

    if imax != i:
        swap(mas, i, imax)
        maxheapify(mas, hsize, imax)


def build_maxheap(mas, hsize):
    iwithleaves = hsize/2 - 1
    while iwithleaves >= 0:
        maxheapify(mas, hsize, iwithleaves)
        iwithleaves -= 1


if __name__ == '__main__':
    mas = []
    for i in xrange(20):
        mas.append(random.randint(0, 99))

    print(mas)
    sort_heap(mas)
    print(mas)
