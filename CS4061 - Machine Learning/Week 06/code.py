from sklearn.dummy import DummyRegressor
from sklearn.kernel_ridge import KernelRidge
from sklearn.model_selection import cross_val_score
from sklearn.neighbors import KNeighborsRegressor
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd

# generate a lambda kernel function for a given gamma value rather than 
#   manually writing seperate functions for each gamma value
def generate_gaussian_kernel_function(gamma):
    weights = lambda dists: np.exp(-gamma * (dists ** 2))
    return lambda dists: weights(dists) / np.sum(weights(dists))

# select specific feature from the data
def filter_data(data, index):
    return [d[index] for d in data]

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

def part_ii_a(X_train, Y_train):
    legend = []
    gammas = [0, 1, 5, 10, 25, 50, 100]
    for gamma in gammas:
        # train model and make predictions
        kernel = generate_gaussian_kernel_function(gamma)
        model = KNeighborsRegressor(n_neighbors=len(X_train), weights=kernel).fit(X_train, Y_train)
        X_test = np.linspace(-3, 3, num=1000).reshape(-1, 1)
        Y_pred = model.predict(X_test)
        plt.plot(X_test, Y_pred)
        legend.append(f'$\\gamma = {gamma}$')
    # configure and show plot
    plt.scatter(X_train, Y_train, color='#444444', marker='+')
    legend.append('train')
    plt.xlabel('$x$')
    plt.ylabel('$y$')
    plt.legend(legend)
    plt.show()

def part_ii_b(X_train, Y_train):
    legend = []
    C_range = [0.1, 1, 10, 1000]
    gammas = [0, 1, 5, 10, 25, 50, 100]
    for C in C_range:
        for gamma in gammas:
            # train model and make predictions
            model = KernelRidge(alpha=1/(2*C), kernel='rbf', gamma=gamma).fit(X_train, Y_train)
            X_test = np.linspace(-3, 3, num=1000).reshape(-1, 1)
            Y_pred = model.predict(X_test)
            plt.plot(X_test, Y_pred)
            legend.append(f'$\\gamma = {gamma}$')
        # configure and show plot
        plt.scatter(X_train, Y_train, color='#444444', marker='+')
        legend.append('train')
        plt.xlabel('$x$')
        plt.ylabel('$y$')
        plt.legend(legend)
        plt.title(f'$C = {C}$')
        plt.show()

def part_ii_c(X_train, Y_train):
    def knn_cv(X_train, Y_train):
        k = 5
        num_neighbors = int(len(X_train) * (k - 1) / k)
        # calculate baseline scores
        dummy = DummyRegressor(strategy='mean').fit(X_train, Y_train)
        dummy_scores = cross_val_score(dummy, X_train, Y_train, cv=k, scoring='neg_mean_squared_error')
        dummy_mean, dummy_std = dummy_scores.mean(), dummy_scores.std()
        # calculate model scores
        gammas = [0, 1, 5, 10, 25, 50, 100]
        means, stds = [], []
        for gamma in gammas:
            kernel = generate_gaussian_kernel_function(gamma)
            model = KNeighborsRegressor(n_neighbors=num_neighbors, weights=kernel).fit(X_train, Y_train)
            scores = cross_val_score(model, X_train, Y_train, cv=k, scoring='neg_mean_squared_error')
            means.append(scores.mean())
            stds.append(scores.std())
            print(f'gamma = {gamma} >> mean = {scores.mean()} std = {scores.std()}')
        # plot mean and SD for each gamma
        plt.errorbar(gammas, [dummy_mean] * len(gammas), yerr=([dummy_std] * len(gammas)), fmt='y')
        plt.errorbar(gammas, means, yerr=stds, fmt='b')
        plt.xlabel('$\\gamma$')
        plt.ylabel('Mean square error')
        plt.legend(['Baseline error', 'Training error'])
        plt.show()
    def krr_cv(X_train, Y_train):
        k = 5
        # calculate and plot model scores
        legend = []
        C_range = [0.1, 1, 10, 1000]
        gammas = [0, 1, 5, 10, 25, 50, 100]
        for C in C_range:
            means, stds = [], []
            for gamma in gammas:
                model = KernelRidge(alpha=1/(2*C), kernel='rbf', gamma=gamma).fit(X_train, Y_train)
                scores = cross_val_score(model, X_train, Y_train, cv=k, scoring='neg_mean_squared_error')
                means.append(scores.mean())
                stds.append(scores.std())
                print(f'C = {C}, gamma = {gamma} >> mean = {scores.mean()} std = {scores.std()}')
            plt.errorbar(gammas, means, yerr=stds)
            legend.append(f'$C = {C}$ error')
        # calculate and plot baseline scores
        dummy = DummyRegressor(strategy='mean').fit(X_train, Y_train)
        dummy_scores = cross_val_score(dummy, X_train, Y_train, cv=k, scoring='neg_mean_squared_error')
        dummy_mean, dummy_std = dummy_scores.mean(), dummy_scores.std()
        plt.errorbar(gammas, [dummy_mean] * len(gammas), yerr=([dummy_std] * len(gammas)))
        legend.append('Baseline error')
        # configure and show plot
        plt.xlabel('$\\gamma$')
        plt.ylabel('Mean square error')
        plt.legend(legend)
        plt.show()
    
    # cross-validation
    knn_cv(X_train, Y_train)
    krr_cv(X_train, Y_train)
    
    # compare optimised and baseline models
    X_test = np.linspace(-3, 3, num=1000).reshape(-1, 1)

    base_model = DummyRegressor(strategy='mean').fit(X_train, Y_train)
    base_Y_pred = base_model.predict(X_test)
    plt.plot(X_test, base_Y_pred)

    knn_gamma = 100
    knn_kernel = generate_gaussian_kernel_function(knn_gamma)
    knn_model = KNeighborsRegressor(n_neighbors=len(X_train), weights=knn_kernel).fit(X_train, Y_train)
    knn_Y_pred = knn_model.predict(X_test)
    plt.plot(X_test, knn_Y_pred)
    
    krr_gamma, krr_alpha = 1, 0.05
    krr_model = KernelRidge(alpha=krr_alpha, kernel='rbf', gamma=krr_gamma).fit(X_train, Y_train)
    krr_Y_pred = krr_model.predict(X_test)
    plt.plot(X_test, krr_Y_pred)
    
    # configure and show plot
    plt.scatter(X_train, Y_train, color='#444444', marker='+')
    plt.xlabel('$x$')
    plt.ylabel('$y$')
    plt.legend(['Baseline', '$k$NN', 'KRR', 'Training data'])
    plt.show()

def part_i():
    X = np.array([-1, 0, 1]).reshape(-1, 1)
    Y = np.array([0, 1, 0]).reshape(-1, 1)
    part_i_a(X, Y)
    part_i_c(X, Y)

def part_ii():
    data = pd.read_csv('dataset.csv', comment='#').values.tolist()
    X = np.array(filter_data(data, 0)).reshape(-1, 1)
    Y = np.array(filter_data(data, 1)).reshape(-1, 1)
    part_ii_a(X, Y)
    part_ii_b(X, Y)
    part_ii_c(X, Y)

part_i()
part_ii()
