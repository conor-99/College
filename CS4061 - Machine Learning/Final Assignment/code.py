from sklearn.dummy import DummyClassifier
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.linear_model import SGDClassifier
from sklearn.metrics import classification_report, plot_confusion_matrix, plot_roc_curve, accuracy_score
from sklearn.model_selection import cross_val_score, train_test_split
from sklearn.naive_bayes import MultinomialNB
from sklearn.neural_network import MLPClassifier
from sklearn.svm import LinearSVC
import csv
import json_lines
import matplotlib.pyplot as plt
import nltk
import numpy as np
import time

# only needs to be run once
def download_nltk():
    nltk.download('punkt')
    nltk.download('stopwords')
    nltk.download('wordnet')
download_nltk()

# read raw data
def read_original_data():
    X, Y1, Y2 = [], [], []
    with open('dataset.jl', 'rb') as f:
        for line in json_lines.reader(f):
            X.append(line['text'])
            Y1.append(line['voted_up'])
            Y2.append(line['early_access'])
    return X, Y1, Y2

# read translated data
def read_translated_data():
    X, Y1, Y2 = [], [], []
    with open('translated.csv', encoding='UTF-8', newline='') as f:
        reader = csv.reader(f, delimiter=',', quotechar='\"')
        for row in reader:
            X.append(row[0])
            Y1.append(row[1])
            Y2.append(row[2])
    return X, Y1, Y2

# lemmatize all the entries in the dataset
# https://stackoverflow.com/questions/47423854/sklearn-adding-lemmatizer-to-countvectorizer
class Lemmatizer(object):
    def __init__(self):
        self.lem = nltk.stem.WordNetLemmatizer()
    def __call__(self, docs):
        return [self.lem.lemmatize(term) for term in nltk.word_tokenize(docs)]

# run cross-validation for all models
def cross_validation(X, Y, is_part_i=True):
    # different hyper-parameter ranges for each question
    if is_part_i:
        C_rng_bl = [1e-5, 1e-4, 1e-3, 1e-2, 1e-1, 1e0, 1e1, 1e2, 1e3, 1e4, 1e5]
        alpha_rng = [1e-5, 1e-4, 1e-3, 1e-2, 1e-1, 1e0, 1e1]
        C_rng_svc = [1e-4, 1e-3, 1e-2, 1e-1, 1e0, 1e1]
        C_rng_sgd = [1e-1, 1e0, 1e1, 1e2, 1e3, 1e4, 1e5]
    else:
        C_rng_bl = [1e-2, 1e-1, 1e0, 1e1, 1e2]
        alpha_rng = [1e-2, 1e-1, 1e0, 1e1, 1e2]
        C_rng_svc = [1e-2, 1e-1, 1e0, 1e1]
        C_rng_sgd = [1e-1, 1e0, 1e1, 1e2]
    
    # lemmatize and vectorize data
    X = TfidfVectorizer(
        sublinear_tf=True,
        strip_accents='unicode',
        tokenizer=Lemmatizer(),
        ngram_range=(1, 2)
    ).fit_transform(X)
    
    print('=== Baselines ===')
    model = DummyClassifier(strategy='most_frequent')
    scores = cross_val_score(model, X, Y, cv=5, scoring='accuracy')
    blf_means = [scores.mean()] * len(C_rng_bl)
    blf_stds = [scores.std()] * len(C_rng_bl)
    print('Frequent >> (%.4f, %.4f)' % (blf_means[0], blf_stds[0]))
    model = DummyClassifier(strategy='uniform')
    scores = cross_val_score(model, X, Y, cv=5, scoring='accuracy')
    blr_means = [scores.mean()] * len(C_rng_bl)
    blr_stds = [scores.std()] * len(C_rng_bl)
    print('Random >> (%.4f, %.4f)' % (blr_means[0], blr_stds[0]))

    print('=== MultinomialNB ===')
    mnb_means, mnb_stds = [], []
    for alpha in alpha_rng:
        Xtr, Xte, Ytr, Yte = train_test_split(X, Y, test_size=0.2)
        model = MultinomialNB(alpha=alpha).fit(Xtr, Ytr)
        Ypr1 = model.predict(Xte)
        Ypr2 = model.predict(Xtr)
        s1 = accuracy_score(Yte, Ypr1)
        s2 = accuracy_score(Ytr, Ypr2)
        print('a = %f >> (%.4f, %.4f)' % (alpha, s1, s2))
        continue
        model = MultinomialNB(alpha=alpha).fit(X, Y)
        scores = cross_val_score(model, X, Y, cv=5, scoring='accuracy', n_jobs=-1)
        mnb_means.append(scores.mean())
        mnb_stds.append(scores.std())
        print('a = %f >> (%.4f, %.4f)' % (alpha, scores.mean(), scores.std()))

    print('=== LinearSVC ===')
    svc_means, svc_stds = [], []
    for C in C_rng_svc:
        Xtr, Xte, Ytr, Yte = train_test_split(X, Y, test_size=0.2)
        model = LinearSVC(loss='hinge', penalty='l2', C=C, max_iter=10000).fit(Xtr, Ytr)
        Ypr1 = model.predict(Xte)
        Ypr2 = model.predict(Xtr)
        s1 = accuracy_score(Yte, Ypr1)
        s2 = accuracy_score(Ytr, Ypr2)
        print('C = %f >> (%.4f, %.4f)' % (C, s1, s2))
        continue
        model = LinearSVC(loss='hinge', penalty='l2', C=C, max_iter=10000).fit(X, Y)
        scores = cross_val_score(model, X, Y, cv=5, scoring='accuracy', n_jobs=-1)
        svc_means.append(scores.mean())
        svc_stds.append(scores.std())
        print('C = %f >> (%.4f, %.4f)' % (C, scores.mean(), scores.std()))

    print('=== SGDClassifier ===')
    sgd_means, sgd_stds = [], []
    for C in C_rng_sgd:
        Xtr, Xte, Ytr, Yte = train_test_split(X, Y, test_size=0.2)
        model = SGDClassifier(loss='log', penalty='l2', alpha=1/C).fit(Xtr, Ytr)
        Ypr1 = model.predict(Xte)
        Ypr2 = model.predict(Xtr)
        s1 = accuracy_score(Yte, Ypr1)
        s2 = accuracy_score(Ytr, Ypr2)
        print('C = %f >> (%.4f, %.4f)' % (C, s1, s2))
        continue
        model = SGDClassifier(loss='log', penalty='l2', alpha=1/C).fit(X, Y)
        scores = cross_val_score(model, X, Y, cv=5, scoring='accuracy', n_jobs=-1)
        sgd_means.append(scores.mean())
        sgd_stds.append(scores.std())
        print('C = %f >> (%.4f, %.4f)' % (C, scores.mean(), scores.std()))
    
    return
    # plot results
    plt.errorbar(alpha_rng, mnb_means, yerr=mnb_stds)
    plt.errorbar(C_rng_svc, svc_means, yerr=svc_stds)
    plt.errorbar(C_rng_sgd, sgd_means, yerr=sgd_stds)
    plt.errorbar(C_rng_bl, blf_means, yerr=blf_stds)
    plt.errorbar(C_rng_bl, blr_means, yerr=blr_stds)
    plt.xticks(C_rng_bl)
    plt.xlabel('$C$ ($\\alpha$ for MNB)')
    plt.ylabel('Mean accuracy score')
    plt.xscale('log')
    plt.legend(
        [
            'MultinomialNB',
            'LinearSVC',
            'SGDClassifier',
            'Baseline (frequent)',
            'Baseline (random)'
        ], loc='lower right'
    )
    if is_part_i: plt.title('Cross-validation results for (i)')
    else: plt.title('Cross-validation results for (ii)')
    plt.show()

# train the optimal model and display results
def optimal_model(X, Y, is_part_i=True):
    # lemmatize and vectorize data
    X = TfidfVectorizer(
        sublinear_tf=True,
        strip_accents='unicode',
        tokenizer=Lemmatizer(),
        ngram_range=(1, 2)
    ).fit_transform(X)

    # train models
    Xtr, Xte, Ytr, Yte = train_test_split(X, Y, test_size=0.2)
    if is_part_i:
        model = MultinomialNB(alpha=1e-1).fit(Xtr, Ytr)
    else:
        model = LinearSVC(loss='hinge', penalty='l2', C=1.0, max_iter=10000).fit(Xtr, Ytr)
    
    # classification reports
    print('=== Test Report ===')
    Ypr1 = model.predict(Xte)
    print(classification_report(Yte, Ypr1))
    print('=== Train Report ===')
    Ypr2 = model.predict(Xtr)
    print(classification_report(Ytr, Ypr2))

    # confusion matrices
    plot_confusion_matrix(model, Xte, Yte)
    plt.show()
    plot_confusion_matrix(model, Xtr, Ytr)
    plt.show()

    # roc curves
    fig, ax = plt.subplots()
    plot_roc_curve(model, Xte, Yte, ax=ax)
    ax.plot([0, 1], [0, 1], linestyle='--', label='Baseline')
    ax.legend(loc='lower right')
    plt.show()

def main():
    X, Y1, Y2 = read_translated_data()
    print('>>> Review Polarity (cross-val) <<<')
    cross_validation(X, Y1, is_part_i=True)
    print('>>> Early Access Game (cross-val) <<<')
    #cross_validation(X, Y2, is_part_i=False)
    print('>>> Review Polarity (optimal model) <<<')
    #optimal_model(X, Y1, is_part_i=True)
    print('>>> Early Access Game (optimal model) <<<')
    #optimal_model(X, Y2, is_part_i=False)

main()
