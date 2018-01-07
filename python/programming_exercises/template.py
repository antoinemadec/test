#!/usr/bin/env python3

import sys
import re
import subprocess
import requests

q_idx = int(sys.argv[1])

URL = 'https://raw.githubusercontent.com/zhiwehu/Python-programming-exercises/master/100%2B%20Python%20challenging%20programming%20exercises.txt'
page_source = requests.get(URL)

# create dir and file
file_dir = "q%s" % q_idx
file_path = "%s/q%s.py" % (file_dir,q_idx)
subprocess.check_call(["mkdir", file_dir])
subprocess.check_call(["touch", file_path])
subprocess.check_call(["chmod", "+x", file_path])

# find question
cur_q_idx = 0
question = []
for line in page_source.text.split('\n'):
    if re.match("^Question:",line) != None:
        cur_q_idx += 1
        indent = ""
    else:
        indent = "    "
    if q_idx == cur_q_idx:
        if re.match("^Hint", line):
            break
        else:
            question.append((indent + line,"")[line==""])

# write file template
fd = open(file_path, "w")
fd.write("""#!/usr/bin/env python3

print(\"\"\"%s

%s
Answer:\"\"\")
""" % (URL, '\n'.join(question)))
