import sys
import random
import time

import sort_simple
import sort_merge
import sort_heap
import sort_quick

def test_sort(sort_func, sname, mas):
    mtosort = mas[:]
    tstart = time.time()
    sort_func(mtosort)
    tend = time.time()
    print("%f seconds - %s" % (tend - tstart, sname))


SORT_FUNCS = (
    (sort_simple.sort_insertion, "insertion"),
    (sort_simple.sort_insertion_optimized, "insertion opt"),
    (sort_simple.sort_bubble, "bubble"),
    (sort_simple.sort_bubble_opimized, "bubble opt"),
    (sort_simple.sort_gnome, "gnome"),
    (sort_simple.sort_gnome_optimized, "gnome opt"),
    (sort_simple.sort_selection, "selection"),
    (sort_merge.sort_merge, "merge"),
    (sort_heap.sort_heap, "heap"),
    (sort_quick.sort_quick, "quick")
)


if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("FORMAT: sort_test.py [array length]")
        exit()

    mas = []
    for i in xrange(int(sys.argv[1])):
        mas.append(random.randint(0, 99))

    for sort_func, sort_name in SORT_FUNCS:
        test_sort(sort_func, sort_name, mas)
