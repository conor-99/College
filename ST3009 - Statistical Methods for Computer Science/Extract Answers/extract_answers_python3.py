"""

Usage:
- python extract_answers.py [week]
- python extract_answers.py 1
- etc.

"""

import re, sys, urllib.request

url_template = "https://www.scss.tcd.ie/doug.leith/ST3009/checker.php?q=week%d"
search_string = "parseFloat\('(.*?)'\)"

week_num = int(sys.argv[1])

with urllib.request.urlopen(url_template % (week_num)) as req:
	text = req.read().decode("utf8")

answers = list(map(float, re.findall(search_string, text)))

print(answers,)
