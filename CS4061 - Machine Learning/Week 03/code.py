from matplotlib import cm
from mpl_toolkits.mplot3d import Axes3D
from sklearn.dummy import DummyRegressor
from sklearn.linear_model import Lasso, Ridge
from sklearn.metrics import accuracy_score
from sklearn.model_selection import cross_val_score
from sklearn.preprocessing import PolynomialFeatures
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd

# select specific feature from the data
def filter_data(data, index):
    return [d[index] for d in data]

# plot the training data as well as a model's predicted results
def plot_training_data_and_predictions(training_data, pred_data, pred_results):
    fig = plt.figure()
    ax = fig.add_subplot(111, projection='3d')
    # plot predictions
    X1 = filter_data(pred_data, 0)
    X2 = filter_data(pred_data, 1)
    ax.plot_trisurf(X1, X2, pred_results, vmin=-100, vmax=100, color='#0000ff80')
    # plot training data
    X = filter_data(training_data, 0)
    Y = filter_data(training_data, 1)
    Z = filter_data(training_data, 2)
    ax.scatter(X, Y, Z, c='#ee000088', edgecolors='#ee0000', s=8)
    # configure and show plot
    ax.zaxis.set_rotate_label(False)
    ax.set_xlabel('$x_1$')
    ax.set_ylabel('$x_2$')
    ax.set_zlabel('target', rotation=0)
    ax.set_xlim3d(-3, 3)
    ax.set_ylim3d(-3, 3)
    ax.set_zlim3d(-30, 30)
    plt.show()

def part_i_a(data):
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

def part_i_bc(data, is_lasso=True):
    # generate new polynomial features
    X1 = np.array(filter_data(data, 0)).reshape(-1, 1)
    X2 = np.array(filter_data(data, 1)).reshape(-1, 1)
    X = np.column_stack((X1, X2))
    X_poly = PolynomialFeatures(5).fit_transform(X)
    Y = np.array(filter_data(data, 2))
    # generate grid of feature values using Numpy magic
    X_test = np.mgrid[-3:3.5:0.5, -3:3.5:0.5].reshape(2, -1).T
    X_test_poly = PolynomialFeatures(5).fit_transform(X_test)
    # train models and make predictions
    C_range = [1, 10, 100, 1000] if is_lasso else [0.0001, 0.001, 0.01, 0.1]
    for C in C_range:
        if is_lasso: model = Lasso(alpha=1/(2*C)).fit(X_poly, Y)
        else: model = Ridge(alpha=1/(2*C)).fit(X_poly, Y)
        predictions = model.predict(X_test_poly)
        print(f'C = {C} >> intercept = {model.intercept_}, coefs = {list(model.coef_)}')
        plot_training_data_and_predictions(data, list(X_test), list(predictions))

def part_i(data):
    part_i_a(data)
    part_i_bc(data, is_lasso=True)
    part_i_bc(data, is_lasso=False)

def part_ii_a(data):
    # generate new polynomial features
    X1 = np.array(filter_data(data, 0)).reshape(-1, 1)
    X2 = np.array(filter_data(data, 1)).reshape(-1, 1)
    X = np.column_stack((X1, X2))
    X_poly = PolynomialFeatures(5).fit_transform(X)
    Y = np.array(filter_data(data, 2))
    # train models and run cross-validations
    C = 1
    k_range = [2, 5, 10, 25, 50, 100]
    model = Lasso(alpha=1/(2*C)).fit(X_poly, Y)
    dummy = DummyRegressor(strategy='mean').fit(X_poly, Y)
    means, stds, _vars = [], [], []
    dummy_means, dummy_stds, dummy_vars = [], [], []
    for k in k_range:
        # calculate baseline scores
        dummy_scores = cross_val_score(dummy, X_poly, Y, cv=k, scoring='neg_mean_squared_error')
        dummy_means.append(dummy_scores.mean())
        dummy_stds.append(dummy_scores.std())
        dummy_vars.append(pow(dummy_scores.std(), 2))
        # calculate model scores
        scores = cross_val_score(model, X_poly, Y, cv=k, scoring='neg_mean_squared_error')
        mean, std, var = scores.mean(), scores.std(), pow(scores.std(), 2)
        means.append(mean)
        stds.append(std)
        _vars.append(var)
        print(f'k = {k} >> mean = {mean}, std = {std}, var = {var}')
    # plot mean and SD for each k
    plt.errorbar(k_range, dummy_means, yerr=dummy_stds, fmt='y')
    plt.errorbar(k_range, means, yerr=stds, fmt='b')
    plt.xlabel('k')
    plt.ylabel('Mean square error')
    plt.legend(['Baseline error', 'Training error'])
    plt.show()
    # plot mean and variance for each k
    plt.errorbar(k_range, dummy_means, yerr=dummy_vars, fmt='y')
    plt.errorbar(k_range, means, yerr=_vars, fmt='b')
    plt.xlabel('k')
    plt.ylabel('Mean square error')
    plt.legend(['Baseline error', 'Training error'])
    plt.show()

def part_ii_b(data, is_lasso=True):
    # generate new polynomial features
    X1 = np.array(filter_data(data, 0)).reshape(-1, 1)
    X2 = np.array(filter_data(data, 1)).reshape(-1, 1)
    X = np.column_stack((X1, X2))
    X_poly = PolynomialFeatures(5).fit_transform(X)
    Y = np.array(filter_data(data, 2))
    # initialse k and C
    k = 10
    if is_lasso: C_range = [0.1, 1, 10, 100, 1000]
    else: C_range = [0.00001, 0.0001, 0.001, 0.01, 0.1]
    # calculate baseline scores
    dummy = DummyRegressor(strategy='mean').fit(X_poly, Y)
    dummy_scores = cross_val_score(dummy, X_poly, Y, cv=k, scoring='neg_mean_squared_error')
    dummy_mean = dummy_scores.mean()
    # train models and run cross-validations
    means, stds = [], []
    for C in C_range:
        if is_lasso: model = Lasso(alpha=1/(2*C)).fit(X_poly, Y)
        else: model = Ridge(alpha=1/(2*C)).fit(X_poly, Y)
        scores = cross_val_score(model, X_poly, Y, cv=k, scoring='neg_mean_squared_error')
        mean, std, var = scores.mean(), scores.std(), pow(scores.std(), 2)
        means.append(mean)
        stds.append(std)
        print(f'C = {C} >> mean = {mean}, std = {std}, var = {var}')
    # plot mean and std for each C
    plt.errorbar(C_range, [dummy_mean] * len(C_range), fmt='y')
    plt.errorbar(C_range, means, yerr=stds, fmt='b')
    plt.xlabel('C')
    plt.ylabel('Mean square error')
    plt.xscale('log')
    plt.legend(['Baseline error', 'Training error'])
    plt.show()
        
def part_ii(data):
    part_ii_a(data)
    part_ii_b(data, is_lasso=True)
    part_ii_b(data, is_lasso=False)

data = pd.read_csv('dataset.csv', comment='#').values.tolist()
part_i(data)
part_ii(data)
