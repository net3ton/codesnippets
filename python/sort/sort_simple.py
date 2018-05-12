import random

def swap(mas, i, j):
    temp = mas[i]
    mas[i] = mas[j]
    mas[j] = temp


def sort_insertion(mas):
    i = 1
    while i < len(mas):
        si = i - 1
        while mas[si] > mas[si+1] and si >= 0:
            swap(mas, si, si+1)
            si -= 1
        i += 1

# short the count of swaps
def sort_insertion_optimized(mas):
    i = 1
    while i < len(mas):
        si = i
        val = mas[si]
        while mas[si-1] > val and si > 0:
            mas[si] = mas[si-1]
            si -= 1
        mas[si] = val
        i += 1


def sort_bubble(mas):
    changed = True
    while changed:
        changed = False
        i = 1
        while i < len(mas):
            if mas[i-1] > mas[i]:
                swap(mas, i-1, i)
                changed = True
            i += 1

# cut array to the max popped item
def sort_bubble_opimized(mas):
    count = len(mas)
    while count > 0:
        i = 1
        lastswapped = 0
        while i < count:
            if mas[i-1] > mas[i]:
                swap(mas, i-1, i)
                lastswapped = i
            i += 1
        count = lastswapped


def sort_gnome(mas):
    i = 0
    while i < len(mas):
        if i == 0 or mas[i-1] <= mas[i]:
            i += 1
        else:
            swap(mas, i-1, i)
            i -= 1

# teleport gnome to the last position
def sort_gnome_optimized(mas):
    i = 1
    while i < len(mas):
        pos = i
        while pos > 0 and mas[pos-1] > mas[pos]:
            swap(mas, pos-1, pos)
            pos -= 1
        i += 1


def sort_selection(mas):
    pos = 0
    while pos < len(mas) - 1:
        min = pos
        i = pos + 1
        while i < len(mas):
            if mas[i] < mas[min]:
                min = i
            i += 1
        if pos != min:
            swap(mas, pos, min)
        pos += 1


if __name__ == '__main__':
    mas = []
    for i in xrange(20):
        mas.append(random.randint(0, 99))

    print(mas)
    sort_selection(mas)
    print(mas)
