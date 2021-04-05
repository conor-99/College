from google_trans_new import google_translator
import csv
import json_lines

with open('dataset.jl', 'rb') as f1:
    with open('translated.csv', 'w+', encoding='UTF-8', newline='') as f2:
        i = 0
        trans = google_translator()
        writer = csv.writer(f2, delimiter=',', quotechar='\"')
        for line in json_lines.reader(f1):
            raw = line['text']
            # don't translate very long reviews
            if len(raw) >= 5000: result = raw
            else: result = trans.translate(raw, lang_tgt='en')
            writer.writerow([result, line['voted_up'], line['early_access']])
            if not i % 10: print(i)
            i += 1
