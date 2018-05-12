import random

def swap(mas, i1, i2):
    if i1 != i2:
        temp = mas[i1]
        mas[i1] = mas[i2]
        mas[i2] = temp


def sort_quick_sub(mas, istart, iend):
    if (istart >= iend):
        return

    med = mas[iend]

    ism = istart
    i = istart
    while i < iend:
        if mas[i] < med:
            swap(mas, i, ism)
            ism += 1
        i += 1

    swap(mas, ism, iend)

    sort_quick_sub(mas, istart, ism-1)
    sort_quick_sub(mas, ism+1, iend)


def sort_quick(mas):
    sort_quick_sub(mas, 0, len(mas)-1)


if __name__ == '__main__':
    mas = []
    for i in xrange(20):
        mas.append(random.randint(0, 99))

    print(mas)
    sort_quick(mas)
    print(mas)
