from matplotlib import cm
from mpl_toolkits.mplot3d import Axes3D
from sklearn.dummy import DummyClassifier
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import confusion_matrix, roc_curve
from sklearn.model_selection import cross_val_score, train_test_split
from sklearn.neighbors import KNeighborsClassifier
from sklearn.preprocessing import PolynomialFeatures
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import warnings

# suppress SciKit warnings
warnings.filterwarnings('ignore')

# select specific feature from the data
def filter_data(data, index):
    return [d[index] for d in data]

# reshape data into X and Y arrays
def reshape_data(data):
    X1 = np.array(filter_data(data, 0)).reshape(-1, 1)
    X2 = np.array(filter_data(data, 1)).reshape(-1, 1)
    X = np.column_stack((X1, X2))
    Y = np.array(filter_data(data, 2))
    return X, Y

# plot only the dataset
def plot_dataset(data):
    X = filter_data(data, 0)
    Y = filter_data(data, 1)
    Z = filter_data(data, 2)
    fig = plt.figure()
    ax = fig.add_subplot(111, projection='3d')
    ax.scatter(X, Y, Z)
    ax.set_xlabel('$x_1$')
    ax.set_ylabel('$x_2$')
    ax.zaxis.set_rotate_label(False)
    ax.set_zlabel('target', rotation=0)
    plt.show()

# plot dataset with predictions
def plot_dataset_with_predictions(data, pred_data, pred_results):
    fig = plt.figure()
    ax = fig.add_subplot(111, projection='3d')
    # plot predictions
    X1 = filter_data(pred_data, 0)
    X2 = filter_data(pred_data, 1)
    ax.scatter(X1, X2, pred_results, c='#0000ff80')
    # plot training data
    X = filter_data(data, 0)
    Y = filter_data(data, 1)
    Z = filter_data(data, 2)
    ax.scatter(X, Y, Z, c='#ee000088', edgecolors='#ee0000', s=8)
    # configure and show plot
    ax.zaxis.set_rotate_label(False)
    ax.set_xlabel('$x_1$')
    ax.set_ylabel('$x_2$')
    ax.set_zlabel('target', rotation=0)
    ax.set_xlim3d(-3, 3)
    ax.set_ylim3d(-3, 3)
    plt.show()

# logistic regression: cross-val, plotting, matrices, ROC, ...
def logistic_regression(data, set_num):
    # reshape data
    X, Y = reshape_data(data)
    
    # initialise baseline models and get scores
    bl_freq = DummyClassifier(strategy='most_frequent')
    bl_freq_scores = cross_val_score(bl_freq, X, Y, cv=5, scoring='accuracy')
    bl_freq_mean, bl_freq_std = bl_freq_scores.mean(), bl_freq_scores.std()
    bl_rand = DummyClassifier(strategy='uniform')
    bl_rand_scores = cross_val_score(bl_rand, X, Y, cv=5, scoring='accuracy')
    bl_rand_mean, bl_rand_std = bl_rand_scores.mean(), bl_rand_scores.std()
    
    # initialise ranges
    if set_num == 1:
        degree_rng = [1, 2, 3, 4, 5, 6]
        C_rng = [0.001, 0.01, 0.1, 1, 10, 100, 1000]
    else:
        degree_rng = [1, 3, 5, 7]
        C_rng = [0.1, 1, 10, 100, 1000, 10000]
    
    # run cross-validation on all models
    for degree in degree_rng:
        X_poly = PolynomialFeatures(degree).fit_transform(X)
        means, stds = [], []
        for C in C_rng:
            model = LogisticRegression(C=C, penalty='l2', solver='lbfgs').fit(X_poly, Y)
            scores = cross_val_score(model, X_poly, Y, cv=5, scoring='accuracy')
            means.append(scores.mean())
            stds.append(scores.std())
        # output relevant data
        print('\ndegree = %d:' % (degree))
        for i, C in enumerate(C_rng):
            print('C = %.3ff >> mean = %.3f, std = %.3f' % (C, means[i], stds[i]))
        # extend baseline values into arrays
        bl_freq_means = [bl_freq_mean] * len(C_rng)
        bl_freq_stds = [bl_freq_std] * len(C_rng)
        bl_rand_means = [bl_rand_mean] * len(C_rng)
        bl_rand_stds = [bl_rand_std] * len(C_rng)
        # plot mean and std deviation for each C along with baselines
        plt.errorbar(C_rng, bl_freq_means, yerr=bl_freq_stds, fmt='y')
        plt.errorbar(C_rng, bl_rand_means, yerr=bl_rand_stds, fmt='g')
        plt.errorbar(C_rng, means, yerr=stds, fmt='b')
        plt.xlabel('C')
        plt.ylabel('Mean accuracy score')
        plt.xscale('log')
        plt.legend(['Baseline (most frequent)', 'Baseline (random)', 'Trained model'])
        plt.title(f'Max degree = {degree}')
        plt.show()
    
    # initialise optimal values
    if set_num == 1:
        degree = 4
        C = 10
    else:
        degree = 1
        C = 1

    # train model and calculate confusion matrix
    X_poly = PolynomialFeatures(degree).fit_transform(X)
    X_train, X_test, Y_train, Y_test = train_test_split(X_poly, Y, test_size=0.2)
    model = LogisticRegression(C=C, penalty='l2', solver='lbfgs').fit(X_train, Y_train)
    Y_pred = model.predict(X_test)
    print(confusion_matrix(Y_test, Y_pred))

    # make predictions for an extended range of feature values
    X_pred = np.mgrid[-3:3.2:0.2, -3:3.2:0.2].reshape(2, -1).T
    X_pred_poly = PolynomialFeatures(degree).fit_transform(X_pred)
    plot_dataset_with_predictions(data, list(X_pred), list(model.predict(X_pred_poly)))

    # calculate confusion matrices for both baselines
    bl_X_train, bl_X_test, bl_Y_train, bl_Y_test = train_test_split(X, Y, test_size=0.2)
    bl_freq.fit(bl_X_train, bl_Y_train)
    bl_freq_pred = bl_freq.predict(bl_X_test)
    bl_freq_cm = confusion_matrix(bl_Y_test, bl_freq_pred)
    print(bl_freq_cm)
    bl_rand.fit(bl_X_train, bl_Y_train)
    bl_rand_pred = bl_rand.predict(bl_X_test)
    bl_rand_cm = confusion_matrix(bl_Y_test, bl_rand_pred)
    print(bl_rand_cm)

    # ROC curve with baseline points
    fpr, tpr, _ = roc_curve(Y_test, model.decision_function(X_test))
    plt.plot(fpr, tpr)
    bl_freq_tpr = bl_freq_cm[1][1] / (bl_freq_cm[1][1] + bl_freq_cm[1][0])
    bl_freq_fpr = bl_freq_cm[0][1] / (bl_freq_cm[0][1] + bl_freq_cm[0][0])
    plt.plot(bl_freq_fpr, bl_freq_tpr, 'rs')
    bl_rand_tpr = bl_rand_cm[1][1] / (bl_rand_cm[1][1] + bl_rand_cm[1][0])
    bl_rand_fpr = bl_rand_cm[0][1] / (bl_rand_cm[0][1] + bl_rand_cm[0][0])
    plt.plot(bl_rand_fpr, bl_rand_tpr, 'gs')
    plt.xlabel('False positive rate')
    plt.ylabel('True positive rate')
    plt.legend(['Trained model', 'Baseline (most frequent)', 'Baseline (random)'])
    plt.show()

# kNN: cross-val, plotting, matrices, ROC, ...
def knn(data, set_num):
    # reshape data
    X, Y = reshape_data(data)
    
    # initialise baseline models and get scores
    bl_freq = DummyClassifier(strategy='most_frequent')
    bl_freq_scores = cross_val_score(bl_freq, X, Y, cv=5, scoring='accuracy')
    bl_freq_mean, bl_freq_std = bl_freq_scores.mean(), bl_freq_scores.std()
    bl_rand = DummyClassifier(strategy='uniform')
    bl_rand_scores = cross_val_score(bl_rand, X, Y, cv=5, scoring='accuracy')
    bl_rand_mean, bl_rand_std = bl_rand_scores.mean(), bl_rand_scores.std()
    
    # initialise ranges
    if set_num == 1:
        degree_rng = [1, 2, 3, 4]
        k_rng = [3, 7, 11, 15, 19, 23, 27, 31, 35, 39]
    else:
        degree_rng = [1, 2, 3, 4]
        k_rng = [3, 7, 11, 15, 19, 23, 27, 31, 35, 39]
    
    # run cross-validation to test effect of polynomial features
    for k in [3, 9, 15, 21]:
        means, stds = [], []
        for degree in degree_rng:
            X_poly = PolynomialFeatures(degree).fit_transform(X)
            model = KNeighborsClassifier(n_neighbors=k, weights='uniform').fit(X_poly, Y)
            scores = cross_val_score(model, X_poly, Y, cv=5, scoring='accuracy')
            means.append(scores.mean())
            stds.append(scores.std())
        # output relevant data
        print('\nk = %d:' % (k))
        for i, degree in enumerate(degree_rng):
            print('degree = %d >> mean = %.3f, std = %.3f' % (degree, means[i], stds[i]))
        # extend baseline values into arrays
        bl_freq_means = [bl_freq_mean] * len(degree_rng)
        bl_freq_stds = [bl_freq_std] * len(degree_rng)
        bl_rand_means = [bl_rand_mean] * len(degree_rng)
        bl_rand_stds = [bl_rand_std] * len(degree_rng)
        # plot mean and std deviation for each C along with baselines
        plt.errorbar(degree_rng, bl_freq_means, yerr=bl_freq_stds, fmt='y')
        plt.errorbar(degree_rng, bl_rand_means, yerr=bl_rand_stds, fmt='g')
        plt.errorbar(degree_rng, means, yerr=stds, fmt='b')
        plt.xlabel('degree')
        plt.ylabel('Mean accuracy score')
        plt.legend(['Baseline (most frequent)', 'Baseline (random)', 'Trained model'])
        plt.title(f'$k = {k}$')
        plt.show()
    
    # run cross-validation on all models with no polynomial features
    def cross_val(k_rng):
        means, stds = [], []
        for k in k_rng:
            model = KNeighborsClassifier(n_neighbors=k, weights='uniform').fit(X, Y)
            scores = cross_val_score(model, X, Y, cv=5, scoring='accuracy')
            means.append(scores.mean())
            stds.append(scores.std())
            print('k = %d >> mean = %.3f, std = %.3f' % (k, scores.mean(), scores.std()))
        # extend baseline values into arrays
        bl_freq_means = [bl_freq_mean] * len(k_rng)
        bl_freq_stds = [bl_freq_std] * len(k_rng)
        bl_rand_means = [bl_rand_mean] * len(k_rng)
        bl_rand_stds = [bl_rand_std] * len(k_rng)
        # plot mean and std deviation for each C along with baselines
        plt.errorbar(k_rng, bl_freq_means, yerr=bl_freq_stds, fmt='y')
        plt.errorbar(k_rng, bl_rand_means, yerr=bl_rand_stds, fmt='g')
        plt.errorbar(k_rng, means, yerr=stds, fmt='b')
        plt.xticks(np.array(k_rng))
        plt.xlabel('$k$')
        plt.ylabel('Mean accuracy score')
        plt.legend(['Baseline (most frequent)', 'Baseline (random)', 'Trained model'])
        plt.show()

    cross_val([5, 10, 25, 50, 100]) # very broad range of values to narrow down optimal k
    if set_num == 1:
        cross_val([3, 5, 7, 9, 11]) # narrower range clustered around apparent optimal k

    # initialise optimal values
    if set_num == 1: k = 7
    else: k = 100

    # train model and calculate confusion matrix
    X_train, X_test, Y_train, Y_test = train_test_split(X, Y, test_size=0.2)
    model = KNeighborsClassifier(n_neighbors=k, weights='uniform').fit(X_train, Y_train)
    Y_pred = model.predict(X_test)
    print(confusion_matrix(Y_test, Y_pred))

    # make predictions for an extended range of feature values
    X_pred = np.mgrid[-3:3.2:0.2, -3:3.2:0.2].reshape(2, -1).T
    plot_dataset_with_predictions(data, list(X_pred), list(model.predict(X_pred)))

    # calculate confusion matrices for both baselines
    bl_X_train, bl_X_test, bl_Y_train, bl_Y_test = train_test_split(X, Y, test_size=0.2)
    bl_freq.fit(bl_X_train, bl_Y_train)
    bl_freq_pred = bl_freq.predict(bl_X_test)
    bl_freq_cm = confusion_matrix(bl_Y_test, bl_freq_pred)
    print(bl_freq_cm)
    bl_rand.fit(bl_X_train, bl_Y_train)
    bl_rand_pred = bl_rand.predict(bl_X_test)
    bl_rand_cm = confusion_matrix(bl_Y_test, bl_rand_pred)
    print(bl_rand_cm)

    # ROC curve with baseline points
    fpr, tpr, _ = roc_curve(Y_test, model.predict_proba(X_test)[:, 1])
    plt.plot(fpr, tpr)
    bl_freq_tpr = bl_freq_cm[1][1] / (bl_freq_cm[1][1] + bl_freq_cm[1][0])
    bl_freq_fpr = bl_freq_cm[0][1] / (bl_freq_cm[0][1] + bl_freq_cm[0][0])
    plt.plot(bl_freq_fpr, bl_freq_tpr, 'rs')
    bl_rand_tpr = bl_rand_cm[1][1] / (bl_rand_cm[1][1] + bl_rand_cm[1][0])
    bl_rand_fpr = bl_rand_cm[0][1] / (bl_rand_cm[0][1] + bl_rand_cm[0][0])
    plt.plot(bl_rand_fpr, bl_rand_tpr, 'gs')
    plt.xlabel('False positive rate')
    plt.ylabel('True positive rate')
    plt.legend(['Trained model', 'Baseline (most frequent)', 'Baseline (random)'])
    plt.show()

def main(data, set_num):
    #plot_dataset(data)
    logistic_regression(data, set_num)
    knn(data, set_num)

data1 = pd.read_csv('dataset1.csv', comment='#').values.tolist()
data2 = pd.read_csv('dataset2.csv', comment='#').values.tolist()
main(data1, set_num=1)
main(data2, set_num=2)
