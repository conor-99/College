from sklearn.linear_model import LogisticRegression
from sklearn.metrics import accuracy_score
from sklearn.svm import LinearSVC
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd

# select specific feature from the data with an optional target value filter
def filter_data(data, index, filter=None):
    if filter: return [d[index] for d in data if d[2] == filter]
    else: return [d[index] for d in data]

# plot the training data as well as a model's predicted results
# `boundary_f` is a lambda function for calculating the decision boundary
def plot_training_data_and_predictions(data, predictions, boundary_f=None):
    # plot training data
    X1, Y1 = filter_data(data, 0, filter=1), filter_data(data, 1, filter=1)
    X2, Y2 = filter_data(data, 0, filter=-1), filter_data(data, 1, filter=-1)
    plt.scatter(X1, Y1, marker='o', c='#00ff00', s=4)
    plt.scatter(X2, Y2, marker='o', c='#0000ff', s=4)
    # plot only the incorrect predictions instead of replotting everything
    X1, Y1 = [], []
    X2, Y2 = [], []
    for i, target in enumerate(predictions):
        if target == 1 and data[i][2] != 1:
            X1.append(data[i][0])
            Y1.append(data[i][1])
        elif target == -1 and data[i][2] != -1:
            X2.append(data[i][0])
            Y2.append(data[i][1])
    plt.scatter(X1, Y1, marker='o', c='#a37200', s=4)
    plt.scatter(X2, Y2, marker='o', c='#0e1e33', s=4)
    # calculate and plot decision boundary
    if boundary_f:
        X = np.arange(-1, 1.1, 0.1)
        plt.plot(X, boundary_f(X), c='#dd0000', linewidth=1)
    # show plot
    plt.xlabel('$x_1$')
    plt.ylabel('$x_2$')
    if boundary_f:
        plt.legend(['decision boundary', 'train +1', 'train -1',
            'predict +1', 'predict -1'])
    else:
        plt.legend(['train +1', 'train -1',
            'predict +1', 'predict -1'])
    plt.show()
    return

def part_a_i(data):
    X1, Y1 = filter_data(data, 0, filter=1), filter_data(data, 1, filter=1)
    X2, Y2 = filter_data(data, 0, filter=-1), filter_data(data, 1, filter=-1)
    plt.scatter(X1, Y1, marker='o', c='#00ff00', s=4)
    plt.scatter(X2, Y2, marker='o', c='#0000ff', s=4)
    plt.xlabel('$x_1$')
    plt.ylabel('$x_2$')
    plt.show()

def part_a_ii(data):
    X1 = np.array(filter_data(data, 0)).reshape(-1, 1)
    X2 = np.array(filter_data(data, 1)).reshape(-1, 1)
    X = np.column_stack((X1, X2))
    Y = np.array(filter_data(data, 2))
    model = LogisticRegression(penalty='none', solver='lbfgs').fit(X, Y)
    print('intercept = %f, slopes = (%f, %f)' %
        (model.intercept_, *model.coef_[0]))
    return model

def part_a_iii(data, model):
    # use trained model to predict target values
    X1 = np.array(filter_data(data, 0)).reshape(-1, 1)
    X2 = np.array(filter_data(data, 1)).reshape(-1, 1)
    X = np.column_stack((X1, X2))
    Y = np.array(filter_data(data, 2))
    predictions = model.predict(X)
    accuracy = accuracy_score(Y, predictions)
    print('accuracy = %f' % (accuracy))
    # set up decision boundary function
    m0, m1, c = model.coef_[0][0], model.coef_[0][1], model.intercept_
    boundary_f = lambda x: -((m0 * x) + c) / m1
    # plot everything
    plot_training_data_and_predictions(data, list(predictions), boundary_f)

def part_a(data):
    part_a_i(data)
    model = part_a_ii(data)
    part_a_iii(data, model)

def part_b(data):
    X1 = np.array(filter_data(data, 0)).reshape(-1, 1)
    X2 = np.array(filter_data(data, 1)).reshape(-1, 1)
    X = np.column_stack((X1, X2))
    Y = np.array(filter_data(data, 2))
    for C in (0.001, 1, 1000):
        # train model and predict target values
        model = LinearSVC(C=C).fit(X, Y)
        predictions = model.predict(X)
        accuracy = accuracy_score(Y, predictions)
        print('C = %f >> intercept = %f, slopes = (%f, %f) >> accuracy = %f' %
            (C, model.intercept_, *model.coef_[0], accuracy))
        # set up decision boundary function
        m0, m1, c = model.coef_[0][0], model.coef_[0][1], model.intercept_
        boundary_f = lambda x: -((m0 * x) / m1 + (c / m1))
        # plot everything
        plot_training_data_and_predictions(data, list(predictions), boundary_f)

def part_c(data):
    # add new features
    X1, X2, X3, X4 = [], [], [], []
    for x1, x2, _ in data:
        X1.append(x1)
        X2.append(x2)
        X3.append(pow(x1, 2))
        X4.append(pow(x2, 2))
    # train a model and predict target values
    X1 = np.array(X1).reshape(-1, 1)
    X2 = np.array(X2).reshape(-1, 1)
    X3 = np.array(X3).reshape(-1, 1)
    X4 = np.array(X4).reshape(-1, 1)
    X = np.column_stack((X1, X2, X3, X4))
    Y = np.array(filter_data(data, 2))
    model = LogisticRegression(penalty='none', solver='lbfgs').fit(X, Y)
    print('intercept = %f, slopes = (%f, %f, %f, %f)' %
        (model.intercept_, *model.coef_[0]))
    predictions = model.predict(X)
    accuracy = accuracy_score(Y, predictions)
    print('accuracy = %f' % (accuracy))
    # set up decision boundary function
    m0, m1, m2, m3 = model.coef_[0]
    c = model.intercept_
    boundary_f = lambda x: (-m1 + pow(m1*m1 - 4*m3*(m2*x*x + m0*x + c), 0.5)) / 2*m3
    # plot everything
    plot_training_data_and_predictions(data, list(predictions), boundary_f)

data = pd.read_csv('dataset.csv', comment='#').values.tolist()
part_a(data)
part_b(data)
part_c(data)
