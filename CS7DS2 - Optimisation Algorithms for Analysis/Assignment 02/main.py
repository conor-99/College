from copy import deepcopy
import matplotlib.pyplot as plt
import numpy as np
import sympy as sp

def plot_contour(f, x_rng, y_rng, data):
    plt.figure(2)
    X = np.linspace(x_rng[0], x_rng[1], 100)
    Y = np.linspace(y_rng[0], y_rng[1], 100)
    Z = []
    for x in X:
        z = []
        for y in Y: z.append(f(x, y))
        Z.append(z)
    Z = np.array(Z)
    X, Y = np.meshgrid(X, Y)
    plt.contour(X, Y, Z, 10)
    for datum in data:
        Xs = np.array(datum[0])
        Ys = np.array(datum[1])
        plt.plot(Xs, Ys)
        #plt.scatter(Xs[::20], Ys[::20])
    plt.xlim(x_rng)
    plt.ylim(y_rng)
    plt.xlabel('$x$')
    plt.ylabel('$y$')
    plt.show()

def get_function_derivatives():
    x, y = sp.symbols('x y', real=True)
    # function 1
    f1 = (9 * ((x - 5) ** 4)) + (10 * ((y - 2) ** 2))
    df1_x = sp.diff(f1, x)
    df1_y = sp.diff(f1, y)
    print(f1)
    print(df1_x)
    print(df1_y)
    # function 2
    f2 = sp.Max(x - 5, 0) + (10 * sp.Abs(y - 2))
    df2_x = sp.diff(f2, x)
    df2_y = sp.diff(f2, y)
    print(f2)
    print(df2_x)
    print(df2_y)

def gd_polyak(f, df, x0, num_iters=100):
    # boilerplate
    x = deepcopy(x0)
    n = len(df)
    xs, fs, steps = [deepcopy(x)], [f(*x)], []
    # constant parameters
    epsilon = 1e-8
    # iterations
    for _ in range(num_iters):
        # calculate step then update values
        step = f(*x) / (sum(df[i](x[i]) ** 2 for i in range(n)) + epsilon)
        for i in range(n):
            x[i] -= step * df[i](x[i])
        # boilerplate
        xs.append(deepcopy(x))
        fs.append(f(*x))
        steps.append(step)
    return xs, fs, steps

def gd_rms_prop(f, df, x0, params, num_iters=100):
    # boilerplate
    alpha0, beta = params
    x = deepcopy(x0)
    n = len(df)
    xs, fs, steps = [deepcopy(x)], [f(*x)], [[alpha0] * n]
    # constant parameters
    epsilon = 1e-8
    # variable parameters
    sums = [0] * n
    alphas = [alpha0] * n
    # iterations
    for _ in range(num_iters):
        # update values and calculate steps
        for i in range(n):
            x[i] -= alphas[i] * df[i](x[i])
            sums[i] = (beta * sums[i]) + ((1 - beta) * (df[i](x[i]) ** 2))
            alphas[i] = alpha0 / ((sums[i] ** 0.5) + epsilon)
        # boilerplate
        xs.append(deepcopy(x))
        fs.append(f(*x))
        steps.append(deepcopy(alphas))
    return xs, fs, steps

def gd_heavy_ball(f, df, x0, params, num_iters=100):
    # boilerplate
    alpha, beta = params
    x = deepcopy(x0)
    n = len(df)
    xs, fs, steps = [deepcopy(x)], [f(*x)], [0]
    # constant parameters
    epsilon = 1e-8
    # variable parameters
    z = 0
    # iterations
    for _ in range(num_iters):
        # calculate step then update values
        z = (beta * z) + (alpha * f(*x) / (sum(df[i](x[i]) ** 2 for i in range(n)) + epsilon))
        for i in range(n):
            x[i] -= z * df[i](x[i])
        # boilerplate
        xs.append(deepcopy(x))
        fs.append(f(*x))
        steps.append(z)
    return xs, fs, steps

def gd_adam(f, df, x0, params, num_iters=100):
    # boilerplate
    alpha, beta1, beta2 = params
    x = deepcopy(x0)
    n = len(df)
    xs, fs, steps = [deepcopy(x)], [f(*x)], [[0] * n]
    # constant parameters
    epsilon = 1e-8
    # variable parameters
    ms = [0] * n
    vs = [0] * n
    step = [0] * n
    t = 0
    # iterations
    for _ in range(num_iters):
        # calculate steps then update values
        t += 1
        for i in range(n):
            ms[i] = (beta1 * ms[i]) + ((1 - beta1) * df[i](x[i]))
            vs[i] = (beta2 * vs[i]) + ((1 - beta2) * (df[i](x[i]) ** 2))
            m_hat = ms[i] / (1 - (beta1 ** t))
            v_hat = vs[i] / (1 - (beta2 ** t))
            step[i] = alpha * (m_hat / ((v_hat ** 0.5) + epsilon))
            x[i] -= step[i]
        # boilerplate
        xs.append(deepcopy(x))
        fs.append(f(*x))
        steps.append(deepcopy(step))
    return xs, fs, steps

def part_b_i(f, df, x, fnum):
    alpha0s = [0.001, 0.01, 0.1]
    betas = [0.25, 0.9]
    num_iters = 200
    iters = list(range(num_iters + 1))
    legend = []
    for alpha0 in alpha0s:
        for beta in betas:
            xs, values, steps = gd_rms_prop(f, df, x, [alpha0, beta], num_iters=num_iters)
            print(f'alpha0={alpha0}, beta={beta}: final_value={values[-1]}')
            plt.figure(1)
            plt.plot(iters, values)
            stepsx = [step[0] for step in steps]
            stepsy = [step[1] for step in steps]
            plt.figure(2)
            plt.plot(iters, stepsx)
            plt.figure(3)
            plt.plot(iters, stepsy)
    plt.figure(1)
    plt.xlabel('iterations')
    plt.ylabel(f'$f_{fnum}(x,y)$')
    plt.title(f'RMSProp for $f_{fnum}(x,y)$')
    if fnum == 1: plt.ylim([0, 100])
    plt.legend(legend)
    plt.figure(2)
    plt.xlabel('iterations')
    plt.ylabel('step $x$')
    plt.title(f'Step size of $x$ for $f_{fnum}$')
    plt.figure(3)
    plt.xlabel('iterations')
    plt.ylabel('step $y$')
    plt.title(f'Step size of $y$ for $f_{fnum}$')
    plt.show()
    
def part_b_ii(f, df, x, fnum):
    alphas = [0.01, 0.1, 1]
    betas = [0.25, 0.9]
    num_iters = 200
    iters = list(range(num_iters + 1))
    legend = []
    contour_data = []
    for alpha in alphas:
        for beta in betas:
            xs, values, steps = gd_heavy_ball(f, df, x, [alpha, beta], num_iters=num_iters)
            legend.append(f'$\\alpha={alpha},\\, \\beta={beta}$')
            print(f'alpha={alpha}, beta={beta}: final_value={values[-1]}')
            plt.plot(iters, values)
    plt.xlabel('iterations')
    plt.ylabel(f'$f_{fnum}(x,y)$')
    plt.title(f'Heavy Ball for $f_{fnum}(x,y)$')
    if fnum == 1: plt.ylim([0, 200])
    else: plt.ylim([0, 30])
    plt.legend(legend)
    plt.show()

def part_b_iii(f, df, x, fnum):
    alphas = [0.01, 0.1, 1]
    beta1s = [0.25, 0.9]
    beta2s = [0.9, 0.999]
    num_iters = 200
    iters = list(range(num_iters + 1))
    legend = []
    for beta2 in beta2s:
        for alpha in alphas:
            for beta1 in beta1s:
                xs, values, steps = gd_adam(f, df, x, [alpha, beta1, beta2], num_iters=num_iters)
                legend.append(f'$\\alpha={alpha},\\, \\beta_1={beta1}$')
                print(f'alpha={alpha}, beta1={beta1}, beta2={beta2}: final_value={values[-1]}')
                plt.figure(1)
                plt.plot(iters, values)
                stepsx = [step[0] for step in steps]
                stepsy = [step[1] for step in steps]
                plt.figure(2)
                plt.plot(iters, stepsx)
                plt.figure(3)
                plt.plot(iters, stepsy)
        plt.figure(1)
        plt.xlabel('iterations')
        plt.ylabel(f'$f_{fnum}(x,y)$')
        plt.title(f'Adam for $f_{fnum}(x,y),\\, \\beta_2={beta2}$')
        plt.legend(legend)
        plt.figure(2)
        plt.xlabel('iterations')
        plt.ylabel('step $x$')
        plt.title(f'Step size of $x$ for $f_{fnum},\\, \\beta_2={beta2}$')
        plt.figure(3)
        plt.xlabel('iterations')
        plt.ylabel('step $y$')
        plt.title(f'Step size of $y$ for $f_{fnum},\\, \\beta_2={beta2}$')
        plt.show()

def part_b():
    f1 = lambda x, y: 9*(x - 5)**4 + 10*(y - 2)**2
    df1_x = lambda x: 36*(x - 5)**3
    df1_y = lambda y: 20*y - 40
    f2 = lambda x, y: 10*abs(y - 2) + max(0, x - 5)
    df2_x = lambda x: np.heaviside(x - 5, 0)
    df2_y = lambda y: 10*np.sign(y - 2)
    print('(b)(i) f1')
    part_b_i(f1, [df1_x, df1_y], [3, 0], 1)
    print('(b)(i) f2')
    part_b_i(f2, [df2_x, df2_y], [3, 0], 2)
    print('(b)(ii) f1')
    part_b_ii(f1, [df1_x, df1_y], [3, 0], 1)
    print('(b)(ii) f2')
    part_b_ii(f2, [df2_x, df2_y], [3, 0], 2)
    print('(b)(iii) f1')
    part_b_iii(f1, [df1_x, df1_y], [3, 0], 1)
    print('(b)(iii) f2')
    part_b_iii(f2, [df2_x, df2_y], [3, 0], 2)

def part_c():
    f = lambda x: max(x, 0)
    df = lambda x: np.heaviside(x, 0)
    num_iters = 110
    iters = list(range(num_iters + 1))
    # parts (i), (ii) and (iii)
    for x0 in [-1, 1, 100]:
        _, values, _ = gd_rms_prop(f, [df], [x0], [0.01, 0.9], num_iters=num_iters)
        #print(x0, values)
        print(f'RMSProp (x0={x0}): {values[-1]}')
        plt.plot(iters, values)
        _, values, _ = gd_heavy_ball(f, [df], [x0], [1, 0.25], num_iters=num_iters)
        #print(x0, values)
        print(f'Heavy Ball (x0={x0}): {values[-1]}')
        plt.plot(iters, values)
        _, values, _ = gd_adam(f, [df], [x0], [0.01, 0.9, 0.999], num_iters=num_iters)
        #print(x0, values)
        print(f'Adam (x0={x0}): {values[-1]}')
        plt.plot(iters, values)
        plt.xlabel(f'iterations ($x_0={x0}$)')
        plt.ylabel('f(x)')
        plt.legend(['RMSProp', 'Heavy Ball', 'Adam'])
        plt.show()

get_function_derivatives()
part_b()
part_c()
