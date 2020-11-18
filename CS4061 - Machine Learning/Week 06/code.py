from sklearn.kernel_ridge import KernelRidge
from sklearn.neighbors import KNeighborsRegressor
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd

# generate a lambda kernel function for a given gamma value rather than 
#   manually writing seperate functions for each gamma value
def generate_gaussian_kernel_function(gamma):
    weights = lambda dists: np.exp(-gamma * (dists ** 2))
    return lambda dists: weights(dists) / np.sum(weights(dists))

def part_i_a(X_train, Y_train):
    gammas = [0, 1, 5, 10, 25]
    for gamma in gammas:
        # train model and make predictions
        kernel = generate_gaussian_kernel_function(gamma)
        model = KNeighborsRegressor(n_neighbors=3, weights=kernel).fit(X_train, Y_train)
        X_test = np.linspace(-3, 3, num=100).reshape(-1, 1)
        Y_pred = model.predict(X_test)
        # plot training data and predictions
        plt.scatter(X_train, Y_train, color='black')
        plt.plot(X_test, Y_pred, color='red')
        plt.xlabel('$x$')
        plt.ylabel('$y$')
        plt.legend(['predict', 'train'])
        plt.title(f'$\\gamma = {gamma}$')
        plt.show()

def part_i_c(X_train, Y_train):
    X_test = np.linspace(-3, 3, num=100).reshape(-1, 1)
    gammas = [0, 1, 5, 10, 25]
    C_range = [0.1, 1, 1000]
    for gamma in gammas:
        for C in C_range:
            # train model and make predictions
            model = KernelRidge(alpha=1/(2*C), kernel='rbf', gamma=gamma).fit(X_train, Y_train)
            Y_pred = model.predict(X_test)
            plt.plot(X_test, Y_pred)
            print(
                'gamma = %d, C = %d, coefs = (%.5f, %.5f, %.5f)' %
                (gamma, C, model.dual_coef_[0][0], model.dual_coef_[1][0], model.dual_coef_[2][0])
            )
        # configure and show plot
        plt.scatter(X_train, Y_train, color='black')
        plt.xlabel('$x$')
        plt.ylabel('$y$')
        plt.legend(['$C = 0.1$', '$C = 1$', '$C = 1000$', 'train'])
        plt.title(f'$\\gamma = {gamma}$')
        plt.show()
    return

def part_i():
    X = np.array([-1, 0, 1]).reshape(-1, 1)
    Y = np.array([0, 1, 0]).reshape(-1, 1)
    part_i_a(X, Y)
    part_i_c(X, Y)

def part_ii():
    # read data
    return

#part_i()
part_ii()
