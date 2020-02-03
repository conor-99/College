"""

Usage:
- python extract_answers.py [week]
- python extract_answers.py 1
- etc.

"""

import re, sys, urllib2

url_template = "https://www.scss.tcd.ie/doug.leith/ST3009/checker.php?q=week%d"
search_string = "parseFloat\('(.*?)'\)"

week_num = int(sys.argv[1])

text = urllib2.urlopen(url_template % (week_num)).read().decode("utf8")

answers = list(map(float, re.findall(search_string, text)))

print(answers)
