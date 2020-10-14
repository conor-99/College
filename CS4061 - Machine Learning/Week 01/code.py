from random import uniform
from sklearn import linear_model, preprocessing
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd

def normalise(data):
    # normalise using the mean and standard deviation
    mu = sum(data) / len(data)
    sigma = (sum(pow(d - mu, 2) for d in data) / len(data)) ** 0.5
    return list(map(lambda d: (d - mu) / sigma, data))

def h(theta_0, theta_1, x):
    return theta_0 + (theta_1 * x)

def J(theta_0, theta_1, X, Y):
    M = len(X)
    return sum(pow(h(theta_0, theta_1, X[i]) - Y[i], 2) for i in range(M)) / M

def gradient_descent(X, Y, alpha, theta_0, theta_1):
    M, ITERATIONS = len(X), 200
    costs = [None] * ITERATIONS
    for i in range(ITERATIONS):
        costs[i] = J(theta_0, theta_1, X, Y)
        theta_0 += -2 * alpha / M * sum(h(theta_0, theta_1, X[i]) - Y[i] for i in range(M))
        theta_1 += -2 * alpha / M * sum((h(theta_0, theta_1, X[i]) - Y[i]) * X[i] for i in range(M))
    return costs, theta_0, theta_1

def part_i(data):
    X = normalise([d[0] for d in data])
    Y = normalise([d[1] for d in data])
    # randomly select starting parameter values
    start_theta_0, start_theta_1 = uniform(-1, 1), uniform(-1, 1)
    for alpha in [1.0, 0.1, 0.01, 0.001]:
        costs, theta_0, theta_1 = gradient_descent(X, Y, alpha, start_theta_0, start_theta_1)
        print('alpha = %.3f >> theta_0 = %.8f, theta_1 = %.8f, cost = %.8f' % (alpha, theta_0, theta_1, costs[-1]))
        plt.plot(costs)
        plt.xlabel('Iterations')
        plt.ylabel('Cost')
        plt.show()

def part_iii(data):
    X = normalise([d[0] for d in data])
    Y = normalise([d[1] for d in data])
    plt.scatter(X, Y, s=2)
    plt.xlabel('Input')
    plt.ylabel('Output')
    plt.show()
    print('Baseline cost = %.8f' % (J(0, 0, X, Y)))

def part_iv(data):
    X = np.array([d[0] for d in data]).reshape(-1, 1)
    X = preprocessing.StandardScaler().fit_transform(X)
    Y = np.array([d[1] for d in data]).reshape(-1, 1)
    Y = preprocessing.StandardScaler().fit_transform(Y)
    model = linear_model.LinearRegression().fit(X, Y)
    print('theta_0 = %.8f, theta_1 = %.8f' % (model.intercept_, model.coef_))

data = pd.read_csv('dataset.csv', comment='#').values.tolist()
part_i(data)
part_iii(data)
part_iv(data)
