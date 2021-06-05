#!/usr/bin/env python3

import matplotlib.pyplot as plt


dates = ['2021/05/01', '2021/06/01']
pass_nb = (46, 56)
fail_nb = (15, 8)
tbd_nb = (30, 28)
labels = ('pass', 'fail', 'tbd')
colors=('#b0b846', '#db4740', '#f28534')

bar_width = 0.7

for i in range(len(dates)):
    bottom = 0
    plt.bar(dates[i], pass_nb[i], bar_width, color=colors[0], bottom=bottom)
    bottom += pass_nb[i]
    plt.bar(dates[i], fail_nb[i], bar_width, color=colors[1], bottom=bottom)
    bottom += fail_nb[i]
    plt.bar(dates[i], tbd_nb[i], bar_width, color=colors[2], bottom=bottom)
    bottom += tbd_nb[i]

the_table = plt.table(cellText=(tbd_nb, fail_nb, pass_nb),
                      cellLoc='center',
                      rowLabels=labels[::-1],
                      rowColours=colors[::-1],
                      colLabels=dates,
                      loc='bottom')

# adjust layout to make room for the table
plt.subplots_adjust(left=0.2, bottom=0.2)

plt.title("Test evolution")
plt.xticks([])
plt.ylabel('tests')

plt.savefig('bar.png')
plt.show()
