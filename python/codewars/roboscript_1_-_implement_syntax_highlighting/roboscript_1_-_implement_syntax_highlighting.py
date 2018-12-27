#!/usr/bin/env python3

'''
Your MyRobot-specific (esoteric) scripting language called RoboScript only ever
contains the following characters: F, L, R, the digits 0-9 and brackets (( and
)). Your goal is to write a function highlight which accepts 1 required
argument code which is the RoboScript program passed in as a string and returns
the script with syntax highlighting. The following commands/characters should
have the following colors:

    F - Wrap this command around <span style="color: pink"> and </span> tags so that it is highlighted pink in our editor
    L - Wrap this command around <span style="color: red"> and </span> tags so that it is highlighted red in our editor
    R - Wrap this command around <span style="color: green"> and </span> tags so that it is highlighted green in our editor
    Digits from 0 through 9 - Wrap these around <span style="color: orange"> and </span> tags so that they are highlighted orange in our editor
    Round Brackets - Do not apply any syntax highlighting to these characters

For example:

highlight("F3RF5LF7"); // => "<span style=\"color: pink\">F</span><span
style=\"color: orange\">3</span><span style=\"color: green\">R</span><span
style=\"color: pink\">F</span><span style=\"color: orange\">5</span><span
style=\"color: red\">L</span><span style=\"color: pink\">F</span><span
style=\"color: orange\">7</span>"

And for multiple characters with the same color, simply wrap them with a single
<span> tag of the correct color:

highlight("FFFR345F2LL"); // => "<span style=\"color: pink\">FFF</span><span
style=\"color: green\">R</span><span style=\"color: orange\">345</span><span
style=\"color: pink\">F</span><span style=\"color: orange\">2</span><span
style=\"color: red\">LL</span>"

Note that the use of <span> tags must be exactly the same format as demonstrated above. Even if your solution produces the same visual result as the expected answers, if you miss a space betwen "color:" and "green", for example, you will fail the tests.
'''

def str_with_tags(s):
    tags = ['<span style="color: COLOR">','</span>']
    color = 'pink'
    if s[0] in '()':
        tags = ['','']
    elif s[0] == 'L':
        color = 'red'
    elif s[0] == 'R':
        color = 'green'
    elif s[0].isdigit():
        color = 'orange'
    return tags[0].replace('COLOR',color) + s + tags[1]

def highlight(code):
    r = ''
    s = ''
    mem_c = ''
    for c in code:
        if mem_c and c != mem_c and not (c.isdigit() and mem_c.isdigit()):
            r += str_with_tags(s)
            s = ''
        s += c
        mem_c = c
    return r + str_with_tags(s)


print(highlight("FFFR345F2LL"))
