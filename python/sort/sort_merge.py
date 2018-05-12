import random

def sort_merge(mas):
    size = len(mas)
    if size <= 1:
        return

    med = size/2
    mas1 = mas[:med]
    mas2 = mas[med:]

    sort_merge(mas1)
    sort_merge(mas2)

    i = 0
    i1 = 0
    i2 = 0
    while i<len(mas):
        if mas1[i1] <= mas2[i2]:
            mas[i] = mas1[i1]
            i1 += 1
        else:
            mas[i] = mas2[i2]
            i2 += 1

        i += 1

        # if one of the sublist is empty -> copy remaining items from other sublist
        if i1 >= len(mas1):
            mas[i:] = mas2[i2:]
            break
        if i2 >= len(mas2):
            mas[i:] = mas1[i1:]
            break


if __name__ == '__main__':
    mas = []
    for i in xrange(20):
        mas.append(random.randint(0, 99))

    print(mas)
    sort_merge(mas)
    print(mas)
