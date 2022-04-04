import matplotlib.pyplot as plt
import numpy as np
import tensorflow as tf
from copy import deepcopy
from random import uniform
from tensorflow import keras
from tensorflow.keras import layers, regularizers
from keras.layers import Dense, Dropout, Activation, Flatten, BatchNormalization
from keras.layers import Conv2D, MaxPooling2D, LeakyReLU
from keras.losses import CategoricalCrossentropy
from tensorflow.keras.optimizers import Adam
from sklearn.metrics import confusion_matrix, classification_report
from sklearn.utils import shuffle

def get_model_loss(batch_size, alpha, beta1, beta2, epochs):
    batch_size = int(batch_size) # ensure random values are ints
    epochs = int(epochs) # ensure random values are ints
    num_classes = 10
    input_shape = (32, 32, 3)
    (x_train, y_train), (x_test, y_test) = keras.datasets.cifar10.load_data()
    n = 5000
    x_train = x_train[1:n]; y_train=y_train[1:n]
    x_train = x_train.astype("float32") / 255
    x_test = x_test.astype("float32") / 255
    y_train = keras.utils.to_categorical(y_train, num_classes)
    y_test = keras.utils.to_categorical(y_test, num_classes)
    model = keras.Sequential()
    model.add(Conv2D(16, (3,3), padding='same',
        input_shape=x_train.shape[1:],activation='relu'))
    model.add(Conv2D(16, (3,3), strides=(2,2), padding='same', activation='relu'))
    model.add(Conv2D(32, (3,3), padding='same', activation='relu'))
    model.add(Conv2D(32, (3,3), strides=(2,2), padding='same', activation='relu'))
    model.add(Dropout(0.5))
    model.add(Flatten())
    model.add(Dense(num_classes, activation='softmax',
        kernel_regularizer=regularizers.l1(0.0001)))
    optimizer = Adam(learning_rate=alpha, beta_1=beta1, beta_2=beta2)
    model.compile(loss="categorical_crossentropy", optimizer=optimizer,
        metrics=["accuracy"])
    history = model.fit(x_train, y_train, batch_size=batch_size, epochs=epochs,
        validation_split=0.1, verbose=0)
    y_preds = model.predict(x_test)
    loss = CategoricalCrossentropy()
    return loss(y_test, y_preds).numpy()

def global_search_random(f, n, x_rng, N):
    l = [r[0] for r in x_rng]
    u = [r[1] for r in x_rng]
    best_x = None
    best_f = 1e20
    xs, fs = [], []
    vv = 0
    for _ in range(N):
        this_x = [uniform(l[i], u[i]) for i in range(n)]
        this_f = f(*this_x)
        if this_f < best_f:
            best_x = deepcopy(this_x)
            best_f = this_f
        xs.append(deepcopy(best_x))
        fs.append(best_f)
        print(vv, best_f, best_x)
        vv += 1
    return xs, fs

def global_search_population(f, n, x_rng, N, M, num_iters):
    sort_lists = lambda l0, l1: map(list, zip(*sorted(zip(l0, l1))))
    l = [r[0] for r in x_rng]
    u = [r[1] for r in x_rng]
    best_x = None
    best_f = 1e20
    xs, fs = [], []
    this_xs = [
        [uniform(l[i], u[i]) for i in range(n)]
        for _ in range(N)
    ]
    this_fs = [0] * N
    vv = 0
    for i in range(N):
        this_x = this_xs[i]
        this_f = f(*this_x)
        this_fs[i] = this_f
        if this_f < best_f:
            best_x = deepcopy(this_x)
            best_f = this_f
        xs.append(deepcopy(best_x))
        fs.append(best_f)
        print(vv, best_f, best_x)
        vv += 1
    num_new = (N - M) // M
    vv = 0
    for _ in range(num_iters):
        this_fs, this_xs = sort_lists(this_fs, this_xs)
        for i in range(M):
            this_x = this_xs[i]
            for j in range(num_new):
                # only perturbate appropriate values
                pert_x = [x for x in this_x]
                for ii in range(n):
                    if l[ii] != u[ii]: pert_x[ii] *= uniform(0.8, 1.2)
                #pert_x = [x * uniform(0.8, 1.2) for x in this_x]
                k = M + (i * num_new) + j
                this_xs[k] = deepcopy(pert_x)
                this_fs[k] = f(*pert_x)
                if this_fs[k] < best_f:
                    best_x = deepcopy(this_xs[k])
                    best_f = this_fs[k]
                xs.append(deepcopy(best_x))
                fs.append(best_f)
        print(vv, best_f, best_x)
        vv += 1
    return xs, fs

def c_i():
    n = 5
    x_rng = [
        [1, 128],
        [0.001, 0.001],
        [0.9, 0.9],
        [0.999, 0.999],
        [20, 20]
    ]
    print('gsr')
    gsr_xs, gsr_fs = global_search_random(get_model_loss, n, x_rng, N=50)
    print('gsp')
    gsp_xs, gsp_fs = global_search_population(get_model_loss, n, x_rng, N=12, M=4,
        num_iters=4)
    return gsr_xs, gsr_fs, gsp_xs, gsp_fs

def c_ii():
    n = 5
    x_rng = [
        [45, 45], # chosen from c(i)
        [0.1, 0.0001],
        [0.25, 0.99],
        [0.9, 0.9999],
        [20, 20]
    ]
    print('gsr')
    gsr_xs, gsr_fs = global_search_random(get_model_loss, n, x_rng, N=50)
    print('gsp')
    gsp_xs, gsp_fs = global_search_population(get_model_loss, n, x_rng, N=12, M=4,
        num_iters=4)
    return gsr_xs, gsr_fs, gsp_xs, gsp_fs

def c_iii():
    n = 5
    x_rng = [
        [45, 45], # chosen from c(i)
        [0.001, 0.001], # ignored c(ii) result
        [0.9, 0.9], # ignored c(ii) result
        [0.999, 0.999], # ignored c(ii) result
        [5, 30]
    ]
    print('gsr')
    gsr_xs, gsr_fs = global_search_random(get_model_loss, n, x_rng, N=50)
    print('gsp')
    gsp_xs, gsp_fs = global_search_population(get_model_loss, n, x_rng, N=12, M=4,
        num_iters=4)
    return gsr_xs, gsr_fs, gsp_xs, gsp_fs

gsr_xs1, gsr_fs1, gsp_xs1, gsp_fs1 = c_i()
gsr_xs2, gsr_fs2, gsp_xs2, gsp_fs2 = c_ii()
gsr_xs3, gsr_fs3, gsp_xs3, gsp_fs3 = c_iii()

def plot_results(gsr_xs, gsr_fs, gsp_xs, gsp_fs):
    gsr_N, gsp_N = len(gsr_fs), len(gsp_fs)
    gsr_X, gsp_X = list(range(gsr_N)), list(range(gsp_N))
    plt.plot(gsr_X, gsr_fs, label='GS Random')
    plt.plot(gsp_X, gsp_fs, label='GS Population')
    plt.xlabel('function evaluations')
    plt.ylabel('model loss')
    plt.legend()
    plt.show()

plot_results(gsr_xs1, gsr_fs1, gsp_xs1, gsp_fs1)
plot_results(gsr_xs2, gsr_fs2, gsp_xs2, gsp_fs2)
plot_results(gsr_xs3, gsr_fs3, gsp_xs3, gsp_fs3)
