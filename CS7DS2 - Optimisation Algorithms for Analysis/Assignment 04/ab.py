from copy import deepcopy
from random import uniform
from timeit import timeit
import matplotlib.pyplot as plt
import numpy as np

def get_function(func_num):
    if func_num == 1:
        f = lambda x, y: 9*(x - 5)**4 + 10*(y - 2)**2
        dfx = lambda x: 36*(x - 5)**3
        dfy = lambda y: 20*y - 40
    else:
        f = lambda x, y: 10*abs(y - 2) + max(0, x - 5)
        dfx = lambda x: np.heaviside(x - 5, 0)
        dfy = lambda y: 10*np.sign(y - 2)
    return f, (dfx, dfy)

def global_search_random(f, n, x_rng, N=1000, is_timed=False):
    # init l and u ranges
    l = [r[0] for r in x_rng]
    u = [r[1] for r in x_rng]
    # init best point and value
    best_x = None
    best_f = 1e20
    # track for plotting
    xs, fs = [], []
    # for each random point
    for _ in range(N):
        # generate point and value
        this_x = [uniform(l[i], u[i]) for i in range(n)]
        this_f = f(*this_x)
        # keep track of best so far
        if this_f < best_f:
            best_x = deepcopy(this_x)
            best_f = this_f
        # for plotting
        if not is_timed:
            xs.append(deepcopy(best_x))
            fs.append(best_f)
    return xs, fs

def global_search_population(f, n, x_rng, N=100, M=10, num_iters=10, is_timed=False):
    # lambda to sort two lists based on values in first list
    sort_lists = lambda l0, l1: map(list, zip(*sorted(zip(l0, l1))))
    # init l and u ranges
    l = [r[0] for r in x_rng]
    u = [r[1] for r in x_rng]
    # init best point and value
    best_x = None
    best_f = 1e20
    # track for plotting
    xs, fs = [], []
    # generate initial set of N points
    this_xs = [
        [uniform(l[i], u[i]) for i in range(n)]
        for _ in range(N)
    ]
    this_fs = [0] * N
    for i in range(N):
        this_x = this_xs[i]
        this_f = f(*this_x)
        this_fs[i] = this_f
        if this_f < best_f:
            best_x = deepcopy(this_x)
            best_f = this_f
        # for plotting
        if not is_timed:
            xs.append(deepcopy(best_x))
            fs.append(best_f)
    # how many points to replace for each good one
    num_new = (N - M) // M
    # for each pruning iteration
    for _ in range(num_iters):
        # sort set of points with best at front
        this_fs, this_xs = sort_lists(this_fs, this_xs)
        # for each of the best M points
        for i in range(M):
            this_x = this_xs[i]
            # replace some bad points with perturbations of this point
            for j in range(num_new):
                pert_x = [x * uniform(0.8, 1.2) for x in this_x] # perturb by 0.8-1.2
                k = M + (i * num_new) + j
                this_xs[k] = deepcopy(pert_x)
                this_fs[k] = f(*pert_x)
                if this_fs[k] < best_f:
                    best_x = deepcopy(this_xs[k])
                    best_f = this_fs[k]
                # for plotting
                if not is_timed:
                    xs.append(deepcopy(best_x))
                    fs.append(best_f)
    return xs, fs

def gradient_descent(f, df, n, x0, alpha=0.01, num_iters=1000, is_timed=False):
    # init best point and value
    this_x = deepcopy(x0)
    this_f = f(*this_x)
    # track for plotting
    xs, fs = [], []
    if not is_timed:
        xs.append(deepcopy(this_x))
        fs.append(this_f)
    # for each iteration
    for _ in range(num_iters):
        # update parameter using gradient
        for i in range(n):
            this_x[i] -= alpha * df[i](this_x[i])
        # calculate value
        this_f = f(*this_x)
        # for plotting
        if not is_timed:
            xs.append(deepcopy(this_x))
            fs.append(this_f)
    return xs, fs

def part_ab_ii(func_num=1, is_part_b=False):
    print(f'=== Function {func_num} ===')
    # get function and init param values
    f, df = get_function(func_num)
    n = 2
    x_rng = [[3, 7], [0, 4]]
    x0 = [7, 7]
    num_iters = 200
    gsp_N, gsp_M, gsp_ni = 20, 5, 10
    # time the algorithms
    gsr_time = timeit(lambda: global_search_random(f, n, x_rng, N=num_iters,
        is_timed=True), number=100)
    gsp_time = timeit(lambda: global_search_population(f, n, x_rng, N=gsp_N, M=gsp_M,
        num_iters=gsp_ni, is_timed=True), number=100)
    gd_time = timeit(lambda: gradient_descent(f, df, n, x0, num_iters=num_iters,
        is_timed=True), number=100)
    print(f'> GSR time = {round(gsr_time, 4)}')
    if is_part_b: print(f'> GSP time = {round(gsp_time, 4)}')
    print(f'> GD time = {round(gd_time, 4)}')
    # run the algorithms
    gsr_xs, gsr_fs = global_search_random(f, n, x_rng, N=num_iters)
    gsp_xs, gsp_fs = global_search_population(f, n, x_rng, N=gsp_N, M=gsp_M,
        num_iters=gsp_ni)
    gd_xs, gd_fs = gradient_descent(f, df, n, x0, num_iters=num_iters)
    # output results
    print('> GSR min = %.6f' % gsr_fs[-1])
    if is_part_b: print('> GSP min = %.6f' % gsp_fs[-1])
    print('> GD min = %.6f' % gd_fs[-1])
    # plot results
    gsr_tpi = gsr_time / len(gsr_fs)
    gsp_tpi = gsp_time / len(gsp_fs)
    gd_tpi = gd_time / len(gd_fs)
    X_gsr = list(range(len(gsr_fs)))
    X_gsp = list(range(len(gsp_fs)))
    X_gd = list(range(len(gd_fs)))
    X_time_gsr = np.array(X_gsr) * gsr_tpi
    X_time_gsp = np.array(X_gsp) * gsp_tpi
    X_time_gd = np.array(X_gd) * gd_tpi
    _, (ax1, ax2) = plt.subplots(1, 2, figsize=(11, 5))
    plt.subplots_adjust(bottom=0.1, left=0.07, top=0.95, right=0.93)
    ax1.plot(X_gsr, gsr_fs, label='GS Random', color='tab:blue')
    if is_part_b: ax1.plot(X_gsp, gsp_fs, label='GS Population', color='tab:red')
    ax1.plot(X_gd, gd_fs, label=f'GD ($\\alpha=0.01$)', color='tab:green')
    ax1.set_xlabel('function evaluations')
    ax1.set_ylabel(f'$f_{func_num}(x)$')
    ax1.set_ylim(0, 5)
    ax1.legend()
    ax2.plot(X_time_gsr, gsr_fs, label='GS Random', color='tab:blue')
    if is_part_b: ax2.plot(X_time_gsp, gsp_fs, label='GS Population', color='tab:red')
    ax2.plot(X_time_gd, gd_fs, label=f'GD ($\\alpha=0.01$)', color='tab:green')
    ax2.set_xlabel('time (s)')
    ax2.set_ylabel(f'$f_{func_num}(x)$')
    ax2.set_ylim(0, 5)
    ax2.legend()
    plt.show()
    if is_part_b:
        if func_num == 1:
            X = np.linspace(-2, 8, 100)
            Y = np.linspace(-2, 8, 100)
        else:
            X = np.linspace(0, 8, 100)
            Y = np.linspace(0, 8, 100)
        Z = []
        for x in X:
            z = []
            for y in Y: z.append(f(x, y))
            Z.append(z)
        Z = np.array(Z)
        X, Y = np.meshgrid(X, Y)
        plt.contour(X, Y, Z, 100)
        plt.xlabel('$x_0$')
        plt.ylabel('$x_1$')
        plt.plot([x[1] for x in gsr_xs], [x[0] for x in gsr_xs],
            color='dimgrey', marker='x', markeredgecolor='tab:blue', markersize=3)
        plt.plot([x[1] for x in gsp_xs], [x[0] for x in gsp_xs],
            color='dimgrey', marker='x', markeredgecolor='tab:red', markersize=3)
        plt.plot([x[1] for x in gd_xs], [x[0] for x in gd_xs],
            color='dimgrey', marker='x', markeredgecolor='tab:green', markersize=3)
        if func_num == 1:
            plt.xlim([-2, 8])
            plt.ylim([0, 8])
        else:
            plt.xlim([0, 7])
            plt.ylim([1, 8])
        plt.show()

part_ab_ii(func_num=1, is_part_b=False)
part_ab_ii(func_num=2, is_part_b=False)
part_ab_ii(func_num=1, is_part_b=True)
part_ab_ii(func_num=2, is_part_b=True)
