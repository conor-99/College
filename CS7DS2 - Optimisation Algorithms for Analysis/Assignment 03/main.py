from copy import deepcopy
from enum import Enum
import matplotlib.pyplot as plt
import numpy as np
import sympy as sp

""" Assignment Functions """

def generate_trainingdata(m=25):
    return np.array([0, 0]) + (0.25 * np.random.randn(m, 2))

def f(x, minibatch):
    # loss function sum_{w in training data} f(x,w)
    y = 0
    count = 0
    for w in minibatch:
        z = x - w - 1
        y = y + min(
            18 * ((z[0] ** 2) + (z[1] ** 2)),
            ((z[0] + 10) ** 2) + ((z[1] + 5) ** 2)
        )
        count = count + 1
    return y / count

""" SGD Algorithm """

class StepSize(Enum):
    CONSTANT = 0
    POLYAK = 1
    RMSPROP = 2
    HEAVYBALL = 3
    ADAM = 4

class SGD:
    epsilon = 1e-8

    def __init__(self, f, df, x, algo, params, batch_size, training):
        # regular params
        self.f = f
        self.df = df
        self.x = deepcopy(x)
        self.n = len(x)
        self.params = params
        # minibatch params
        self.batch_size = batch_size
        self.T = training
        # store results for plotting, etc
        self.logs = {
            'x': [deepcopy(self.x)],
            'f': [self.f(self.x, self.T)],
            'step': []
        }
        # set up for specific step size function
        self.iter_function = self.__get_iter_function(algo)
        self.__init_function_vars(algo)
    
    def run_iter_minibatch(self):
        np.random.shuffle(self.T)
        N = len(self.T)
        for i in range(0, N, self.batch_size):
            if i + self.batch_size > N: continue
            sample = self.T[i:(i + self.batch_size)]
            self.iter_function(sample)
        self.logs['x'].append(deepcopy(self.x))
        self.logs['f'].append(self.f(self.x, self.T))

    def __get_iter_function(self, algo):
        if algo == StepSize.CONSTANT:
            return self.__iter_constant
        elif algo == StepSize.POLYAK:
            return self.__iter__polyak
        elif algo == StepSize.RMSPROP:
            return self.__iter__rmsprop
        elif algo == StepSize.HEAVYBALL:
            return self.__iter__heavy_ball
        else:
            return self.__iter__adam
    
    def __init_function_vars(self, algo):
        if algo == StepSize.RMSPROP:
            self.logs['step'] = [[self.params['alpha0']] * self.n]
            self.vars = {
                'sums': [0] * self.n,
                'alphas': [self.params['alpha0']] * self.n
            }
        elif algo == StepSize.HEAVYBALL:
            self.logs['step'] = [0]
            self.vars = {
                'z': 0
            }
        elif algo == StepSize.ADAM:
            self.logs['step'] = [[0] * self.n]
            self.vars = {
                'ms': [0] * self.n,
                'vs': [0] * self.n,
                'step': [0] * self.n,
                't': 0
            }

    def __iter_constant(self, sample):
        alpha = self.params['alpha']
        for i in range(self.n):
            self.x[i] -= alpha * self.__calc_approx_derivative(i, sample)
        self.logs['step'].append(alpha)

    def __iter__polyak(self, sample):
        step = self.f(self.x, sample) / (
            sum(self.__calc_approx_derivative(i, sample) ** 2
            for i in range(self.n)) + self.epsilon
        )
        for i in range(self.n):
            self.x[i] -= step * self.__calc_approx_derivative(i, sample)
        self.logs['step'].append(step)
    
    def __iter__rmsprop(self, sample):
        alpha0 = self.params['alpha0']
        beta = self.params['beta']
        alphas = self.vars['alphas']
        sums = self.vars['sums']
        for i in range(self.n):
            self.x[i] -= alphas[i] * self.__calc_approx_derivative(i, sample)
            sums[i] = (beta * sums[i]) + ((1 - beta) * (
                self.__calc_approx_derivative(i, sample) ** 2
            ))
            alphas[i] = alpha0 / ((sums[i] ** 0.5) + self.epsilon)
        self.logs['step'].append(deepcopy(alphas))
    
    def __iter__heavy_ball(self, sample):
        alpha = self.params['alpha']
        beta = self.params['beta']
        z = self.vars['z']
        z = (beta * z) + (alpha * self.f(self.x, sample) / (sum(
            self.__calc_approx_derivative(i, sample) ** 2
            for i in range(self.n)
        ) + self.epsilon))
        for i in range(self.n):
            self.x[i] -= z * self.__calc_approx_derivative(i, sample)
        self.vars['z'] = z
        self.logs['step'].append(z)
    
    def __iter__adam(self, sample):
        alpha = self.params['alpha']
        beta1 = self.params['beta1']
        beta2 = self.params['beta2']
        ms = self.vars['ms']
        vs = self.vars['vs']
        step = self.vars['step']
        t = self.vars['t']
        t += 1
        for i in range(self.n):
            ms[i] = (beta1 * ms[i]) + ((1 - beta1) * 
                self.__calc_approx_derivative(i, sample))
            vs[i] = (beta2 * vs[i]) + ((1 - beta2) *
                (self.__calc_approx_derivative(i, sample) ** 2))
            m_hat = ms[i] / (1 - (beta1 ** t))
            v_hat = vs[i] / (1 - (beta2 ** t))
            step[i] = alpha * (m_hat / ((v_hat ** 0.5) + self.epsilon))
            self.x[i] -= step[i]
        self.vars['t'] = t
        self.logs['step'].append(deepcopy(step))

    def __calc_approx_derivative(self, i, sample):
        return sum(
            self.df[i](*self.x, *sample[j])
            for j in range(self.batch_size)
        ) / self.batch_size

""" Question (a) """

def a_ii():
    T = generate_trainingdata()
    X = np.linspace(-15, 10, 100)
    Y = np.linspace(-15, 10, 100)
    Z = []
    for x in X:
        z = []
        for y in Y: z.append(f([x, y], T))
        Z.append(z)
    Z = np.array(Z)
    X, Y = np.meshgrid(X, Y)
    _, (ax1, ax2) = plt.subplots(1, 2, subplot_kw=dict(projection='3d'))
    ax1.contour3D(X, Y, Z, 60)
    ax1.set_xlabel('$x_0$')
    ax1.set_ylabel('$x_1$')
    ax1.set_zlabel('$f(x, T)$')
    ax1.set_title('Contour plot of $f(x, T)$')
    ax2.plot_wireframe(X, Y, Z, rstride=5, cstride=5)
    ax2.set_xlabel('$x_0$')
    ax2.set_ylabel('$x_1$')
    ax2.set_zlabel('$f(x, T)$')
    ax2.set_title('Wireframe plot of $f(x, T)$')
    plt.show()

def a_iii():
    x0, x1, w0, w1 = sp.symbols('x0 x1 w0 w1', real=True)
    f = sp.Min(18*(((x0-w0-1)**2)+((x1-w1-1)**2)),(((x0-w0-1)+10)**2)+(((x1-w1-1)+5)**2))
    df0 = sp.diff(f, x0)
    df1 = sp.diff(f, x1)
    print(f)
    print(df0)
    print(df1)

""" Question (b) """

colors = [
    'tab:blue', 'tab:orange', 'tab:green', 'tab:red', 'tab:purple',
    'tab:brown', 'tab:pink', 'tab:gray', 'tab:olive', 'tab:cyan', 
    'red', 'blue', 'lime'
]

def plot_contour(func, T, xs, fs, rngs=None, is_3d=True, legend=None):
    if rngs is None:
        X = np.linspace(-15, 10, 100)
        Y = np.linspace(-15, 10, 100)
    else:
        X = np.linspace(*rngs[0], 100)
        Y = np.linspace(*rngs[1], 100)
    Z = []
    for x in X:
        z = []
        for y in Y: z.append(func([x, y], T))
        Z.append(z)
    Z = np.array(Z)
    X, Y = np.meshgrid(X, Y)
    if is_3d:
        ax = plt.axes(projection='3d')
        ax.contour3D(X, Y, Z, 60)
        ax.set_xlabel('$x_0$')
        ax.set_ylabel('$x_1$')
        ax.set_zlabel('$f(x, T)$')
    else:
        plt.contour(X, Y, Z, 60)
        plt.xlabel('$x_0$')
        plt.ylabel('$x_1$')
    for i in range(len(xs)):
        x0 = [x[1] for x in xs[i]]
        x1 = [x[0] for x in xs[i]]
        if is_3d:
            ax.plot(x0, x1, fs[i], color='dimgrey',
                marker='x', markeredgecolor=colors[i], markersize=3)
        else:
            plt.plot(x0, x1, color='dimgrey',
                marker='x', markeredgecolor=colors[i], markersize=3)
            plt.xlim([-15, 10])
            plt.ylim([-15, 10])
    if legend is not None: plt.legend(legend)
    plt.show()

def b_i(func, df):
    T = generate_trainingdata()
    num_iters = 100
    ci = 0
    iters = list(range(num_iters + 1))
    alphas = [0.1, 0.01, 0.001, 0.0001]
    labels = [f'$\\alpha={alpha}$' for alpha in alphas]
    xs, fs = [], []
    for i, alpha in enumerate(alphas):
        sgd = SGD(func, df, [3, 3], StepSize.CONSTANT, {'alpha': alpha},
            batch_size=len(T), training=T)
        for _ in range(num_iters):
            sgd.run_iter_minibatch() # not actually mini-batch since batch_size=|T|
        plt.plot(iters, sgd.logs['f'], label=labels[i], color=colors[ci])
        ci += 1
        xs.append(deepcopy(sgd.logs['x']))
        fs.append(deepcopy(sgd.logs['f']))
    plt.ylim([0, 150])
    plt.xlabel('iterations')
    plt.ylabel('$f(x, T)$')
    plt.legend()
    plt.show()
    plot_contour(func, T, xs, fs, is_3d=False, legend=labels)

def b_ii(func, df):
    T = generate_trainingdata()
    num_trials = 5
    num_iters = 10
    ci = 0
    iters = list(range(num_iters + 1))
    alpha = 0.1
    labels = [f'trial ${i+1}$' for i in range(num_trials)]
    xs, fs = [], []
    for trial in range(num_trials):
        sgd = SGD(func, df, [3, 3], StepSize.CONSTANT, {'alpha': alpha}, 5, T)
        for _ in range(num_iters):
            sgd.run_iter_minibatch()
        plt.plot(iters, sgd.logs['f'], label=labels[trial], color=colors[ci])
        ci += 1
        xs.append(deepcopy(sgd.logs['x']))
        fs.append(deepcopy(sgd.logs['f']))
    plt.ylim([0, 20])
    plt.xlabel('iterations')
    plt.ylabel('$f(x, T)$')
    plt.legend()
    plt.show()
    plot_contour(func, T, xs, fs, is_3d=False, legend=labels)

def b_iii(func, df):
    T = generate_trainingdata()
    num_iters = 25
    ci = 0
    iters = list(range(num_iters + 1))
    alpha = 0.1
    batch_sizes = [1, 3, 5, 10, 25]
    labels = [f'$n={n}$' for n in batch_sizes]
    xs, fs = [], []
    for i, n in enumerate(batch_sizes):
        sgd = SGD(func, df, [3, 3], StepSize.CONSTANT, {'alpha': alpha}, n, T)
        for _ in range(num_iters):
            sgd.run_iter_minibatch()
        plt.plot(iters, sgd.logs['f'], label=labels[i], color=colors[ci])
        ci += 1
        xs.append(deepcopy(sgd.logs['x']))
        fs.append(deepcopy(sgd.logs['f']))
    plt.ylim([0, 3])
    plt.xlabel('iterations')
    plt.ylabel('$f(x, T)$')
    plt.legend()
    plt.show()
    plot_contour(func, T, xs, fs, is_3d=False, legend=labels)

def b_iv(func, df):
    T = generate_trainingdata()
    num_iters = 25
    ci = 0
    iters = list(range(num_iters + 1))
    alphas = [0.1, 0.01, 0.001, 0.0001]
    labels = [f'$\\alpha={alpha}$' for alpha in alphas]
    xs, fs = [], []
    for i, alpha in enumerate(alphas):
        sgd = SGD(func, df, [3, 3], StepSize.CONSTANT, {'alpha': alpha}, 5, T)
        for _ in range(num_iters):
            sgd.run_iter_minibatch()
        plt.plot(iters, sgd.logs['f'], label=labels[i], color=colors[ci])
        ci += 1
        xs.append(deepcopy(sgd.logs['x']))
        fs.append(deepcopy(sgd.logs['f']))
    plt.ylim([0, 120])
    plt.xlabel('iterations')
    plt.ylabel('$f(x, T)$')
    plt.legend()
    plt.show()
    plot_contour(func, T, xs, fs, is_3d=False, legend=labels)

""" Question (c) """

def c_i(func, df):
    T = generate_trainingdata()
    num_iters = 100
    iters = list(range(num_iters + 1))
    # results
    ci = 0
    xs, fs = [], []
    labels = ['Baseline']
    # baseline
    sgd_bl = SGD(func, df, [3, 3], StepSize.CONSTANT, {'alpha': 0.1}, 5, T)
    for _ in range(num_iters):
        sgd_bl.run_iter_minibatch()
    plt.plot(iters, sgd_bl.logs['f'], label=labels[0], color=colors[ci])
    ci += 1
    xs.append(deepcopy(sgd_bl.logs['x']))
    fs.append(deepcopy(sgd_bl.logs['f']))
    # polyak
    batch_sizes = [1, 3, 5, 10, 25]
    for n in batch_sizes:
        sgd = SGD(func, df, [3, 3], StepSize.POLYAK, {}, n, T)
        for _ in range(num_iters):
            sgd.run_iter_minibatch()
        labels.append(f'$n={n}$')
        plt.plot(iters, sgd.logs['f'], label=labels[-1], color=colors[ci])
        ci += 1
        xs.append(deepcopy(sgd.logs['x']))
        fs.append(deepcopy(sgd.logs['f']))
    # plotting
    plt.ylim([0, 60])
    plt.xlabel('iterations')
    plt.ylabel('$f(x, T)$')
    plt.legend()
    plt.show()
    # mini-batch variation
    plot_contour(func, T, xs, fs, is_3d=False, legend=labels)

def c_ii(func, df):
    T = generate_trainingdata()
    num_iters = 100
    iters = list(range(num_iters + 1))
    # results
    ci = 0
    xs, fs = [], []
    labels = ['Baseline']
    # baseline
    sgd_bl = SGD(func, df, [3, 3], StepSize.CONSTANT, {'alpha': 0.1}, 5, T)
    for _ in range(num_iters):
        sgd_bl.run_iter_minibatch()
    plt.plot(iters, sgd_bl.logs['f'], label=labels[0], color=colors[ci])
    ci += 1
    xs.append(deepcopy(sgd_bl.logs['x']))
    fs.append(deepcopy(sgd_bl.logs['f']))
    # parameter selection
    alpha0s = [0.1, 0.01, 0.001]
    betas = [0.25, 0.9]
    for alpha0 in alpha0s:
        for beta in betas:
            sgd = SGD(func, df, [3, 3], StepSize.RMSPROP,
                {'alpha0': alpha0, 'beta': beta}, 5, T)
            for _ in range(num_iters):
                sgd.run_iter_minibatch()
            labels.append(f'$\\alpha_0={alpha0},\\,\\beta={beta}$')
            plt.plot(iters, sgd.logs['f'], label=labels[-1], color=colors[ci])
            ci += 1
            xs.append(deepcopy(sgd.logs['x']))
            fs.append(deepcopy(sgd.logs['f']))
    # plotting
    plt.ylim([0, 60])
    plt.xlabel('iterations')
    plt.ylabel('$f(x, T)$')
    plt.legend()
    plt.show()
    # optimal parameters
    ci = 0
    xs, fs = [], []
    labels = ['Baseline']
    plt.plot(iters, sgd_bl.logs['f'], label=labels[0], color=colors[ci])
    ci += 1
    xs.append(deepcopy(sgd_bl.logs['x']))
    fs.append(deepcopy(sgd_bl.logs['f']))
    batch_sizes = [1, 3, 5, 10, 25]
    for n in batch_sizes:
        sgd = SGD(func, df, [3, 3], StepSize.RMSPROP, {'alpha0': 0.1, 'beta': 0.9}, 5, T)
        for _ in range(num_iters):
            sgd.run_iter_minibatch()
        labels.append(f'$n={n}$')
        plt.plot(iters, sgd.logs['f'], label=labels[-1], color=colors[ci])
        ci += 1
        xs.append(deepcopy(sgd.logs['x']))
        fs.append(deepcopy(sgd.logs['f']))
    # plotting
    plt.ylim([0, 10])
    plt.xlabel('iterations')
    plt.ylabel('$f(x, T)$')
    plt.legend()
    plt.show()
    plot_contour(func, T, xs, fs, is_3d=False, legend=labels)

def c_iii(func, df):
    T = generate_trainingdata()
    num_iters = 100
    iters = list(range(num_iters + 1))
    # results
    ci = 0
    xs, fs = [], []
    labels = ['Baseline']
    # baseline
    sgd_bl = SGD(func, df, [3, 3], StepSize.CONSTANT, {'alpha': 0.1}, 5, T)
    for _ in range(num_iters):
        sgd_bl.run_iter_minibatch()
    plt.plot(iters, sgd_bl.logs['f'], label=labels[0], color=colors[ci])
    ci += 1
    xs.append(deepcopy(sgd_bl.logs['x']))
    fs.append(deepcopy(sgd_bl.logs['f']))
    # parameter selection
    alphas = [0.01, 0.001]
    betas = [0.25, 0.5, 0.9]
    for alpha in alphas:
        for beta in betas:
            sgd = SGD(func, df, [3, 3], StepSize.HEAVYBALL,
                {'alpha': alpha, 'beta': beta}, 5, T)
            for _ in range(num_iters):
                sgd.run_iter_minibatch()
            labels.append(f'$\\alpha={alpha},\\,\\beta={beta}$')
            plt.plot(iters, sgd.logs['f'], label=labels[-1], color=colors[ci])
            ci += 1
            xs.append(deepcopy(sgd.logs['x']))
            fs.append(deepcopy(sgd.logs['f']))
    # plotting
    plt.ylim([0, 60])
    plt.xlabel('iterations')
    plt.ylabel('$f(x, T)$')
    plt.legend()
    plt.show()
    # optimal parameters
    ci = 0
    xs, fs = [], []
    labels = ['Baseline']
    plt.plot(iters, sgd_bl.logs['f'], label=labels[0], color=colors[ci])
    ci += 1
    xs.append(deepcopy(sgd_bl.logs['x']))
    fs.append(deepcopy(sgd_bl.logs['f']))
    batch_sizes = [1, 3, 5, 10, 25]
    for n in batch_sizes:
        sgd = SGD(func, df, [3, 3], StepSize.HEAVYBALL,
            {'alpha': 0.01, 'beta': 0.9}, 5, T)
        for _ in range(num_iters):
            sgd.run_iter_minibatch()
        labels.append(f'$n={n}$')
        plt.plot(iters, sgd.logs['f'], label=labels[-1], color=colors[ci])
        ci += 1
        xs.append(deepcopy(sgd.logs['x']))
        fs.append(deepcopy(sgd.logs['f']))
    # plotting
    plt.ylim([0, 10])
    plt.xlabel('iterations')
    plt.ylabel('$f(x, T)$')
    plt.legend()
    plt.show()
    plot_contour(func, T, xs, fs, is_3d=False, legend=labels)

def c_iv(func, df):
    T = generate_trainingdata()
    num_iters = 100
    iters = list(range(num_iters + 1))
    # results
    ci = 0
    xs, fs = [], []
    labels = ['Baseline']
    # baseline
    sgd_bl = SGD(func, df, [3, 3], StepSize.CONSTANT, {'alpha': 0.1}, 5, T)
    for _ in range(num_iters):
        sgd_bl.run_iter_minibatch()
    plt.plot(iters, sgd_bl.logs['f'], label=labels[0], color=colors[ci])
    ci += 1
    xs.append(deepcopy(sgd_bl.logs['x']))
    fs.append(deepcopy(sgd_bl.logs['f']))
    # parameter selection
    alphas = [10, 1, 0.1]
    beta1s = [0.25, 0.9]
    beta2s = [0.999]
    for alpha in alphas:
        for beta1 in beta1s:
            for beta2 in beta2s:
                sgd = SGD(func, df, [3, 3], StepSize.ADAM,
                    {'alpha': alpha, 'beta1': beta1, 'beta2': beta2}, 5, T)
                for _ in range(num_iters):
                    sgd.run_iter_minibatch()
                labels.append(
                    f'$\\alpha={alpha},\\,\\beta_1={beta1},\\,\\beta_2={beta2}$'
                )
                plt.plot(iters, sgd.logs['f'], label=labels[-1], color=colors[ci])
                ci += 1
                xs.append(deepcopy(sgd.logs['x']))
                fs.append(deepcopy(sgd.logs['f']))
    # plotting
    plt.ylim([0, 60])
    plt.xlabel('iterations')
    plt.ylabel('$f(x, T)$')
    plt.legend()
    plt.show()
    # optimal parameters
    ci = 0
    xs, fs = [], []
    labels = ['Baseline']
    plt.plot(iters, sgd_bl.logs['f'], label=labels[0], color=colors[ci])
    ci += 1
    xs.append(deepcopy(sgd_bl.logs['x']))
    fs.append(deepcopy(sgd_bl.logs['f']))
    batch_sizes = [1, 3, 5, 10, 25]
    for n in batch_sizes:
        sgd = SGD(func, df, [3, 3], StepSize.ADAM,
            {'alpha': 10, 'beta1': 0.9, 'beta2': 0.999}, 5, T)
        for _ in range(num_iters):
            sgd.run_iter_minibatch()
        labels.append(f'$n={n}$')
        plt.plot(iters, sgd.logs['f'], label=labels[-1], color=colors[ci])
        ci += 1
        xs.append(deepcopy(sgd.logs['x']))
        fs.append(deepcopy(sgd.logs['f']))
    # plotting
    plt.ylim([0, 10])
    plt.xlabel('iterations')
    plt.ylabel('$f(x, T)$')
    plt.legend()
    plt.show()
    plot_contour(func, T, xs, fs, is_3d=False, legend=labels)

""" Calling Functions """

a_ii()
a_iii()
df0 = lambda x0, x1, w0, w1:\
    (-36*w0+36*x0-36)*np.heaviside(-18*(-w0+x0-1)**2+(-w0+x0+9)**2-18*(-w1+x1-1)**2+(-w1+x1+4)**2,0)+\
    (-2*w0+2*x0+18)*np.heaviside(18*(-w0+x0-1)**2-(-w0+x0+9)**2+18*(-w1+x1-1)**2-(-w1+x1+4)**2,0)
df1 = lambda x0, x1, w0, w1:\
    (-36*w1+36*x1-36)*np.heaviside(-18*(-w0+x0-1)**2+(-w0+x0+9)**2-18*(-w1+x1-1)**2+(-w1+x1+4)**2,0)+\
    (-2*w1+2*x1+8)*np.heaviside(18*(-w0+x0-1)**2-(-w0+x0+9)**2+18*(-w1+x1-1)**2-(-w1+x1+4)**2,0)
b_i(f, [df0, df1])
b_ii(f, [df0, df1])
b_iii(f, [df0, df1])
b_iv(f, [df0, df1])
c_i(f, [df0, df1])
c_ii(f, [df0, df1])
c_iii(f, [df0, df1])
c_iv(f, [df0, df1])
