import json_lines
import spacy
from collections import defaultdict
from spacy_langdetect import LanguageDetector

nlp = spacy.load('en_core_web_sm')
nlp.add_pipe(LanguageDetector(), name='ld')
results = defaultdict(int)

with open('dataset.jl', 'rb') as f:
    for line in json_lines.reader(f):
        results[nlp(line['text'])._.language['language']] += 1

for k, v in results.items():
    print(k, v / 5000)
