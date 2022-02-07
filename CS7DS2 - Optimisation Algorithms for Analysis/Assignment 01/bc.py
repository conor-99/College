import matplotlib.pyplot as plt

def gradient_descent(y, dy, x, alpha, num_iters):
    xs, ys = [x], [y(x)]
    for _ in range(num_iters):
        step = alpha * dy(x)
        x -= step
        xs.append(x)
        ys.append(y(x))
    return xs, ys

def b_ii():
    N = 100
    iters = list(range(N + 1))
    y = lambda x: x**4
    dy = lambda x: 4*(x**3)
    xs, ys = gradient_descent(y, dy, x=1, alpha=0.1, num_iters=N)
    plt.plot(iters, xs)
    plt.plot(iters, ys)
    plt.legend(['$x$', '$y(x)$'])
    plt.xlabel('iterations')
    plt.show()
    
def b_iii():
    N = 100
    iters = list(range(N + 1))
    y = lambda x: x**4
    dy = lambda x: 4*(x**3)
    for alpha in [0.001, 0.01, 0.1, 0.5]:
        for x, color in zip([0.1, 0.5, 1], ['tab:red', 'tab:green', 'tab:blue']):
            xs, ys = gradient_descent(y, dy, x=x, alpha=alpha, num_iters=N)
            plt.plot(iters, xs, linestyle='dotted', color=color)
            plt.plot(iters, ys, color=color)
        plt.legend([
            '$x=0.1$', '$y(x=0.1)$',
            '$x=0.5$', '$y(x=0.5)$',
            '$x=1$', '$y(x=1)$',
        ])
        plt.xlabel(f'iterations ($\\alpha={alpha}$)')
        plt.show()

def c(is_part_i):
    N = 100
    iters = list(range(N + 1))
    gammas = [0.5, 1, 3]
    colors = ['tab:red', 'tab:green', 'tab:blue']
    for gamma, color in zip(gammas, colors):
        if is_part_i:
            y = lambda x: gamma*(x**2)
            dy = lambda x: 2*gamma*x
        else:
            y = lambda x: gamma*abs(x)
            dy = lambda x: (gamma*x)/abs(x)
        xs, ys = gradient_descent(y, dy, x=1, alpha=0.1, num_iters=N)
        plt.plot(iters, xs, linestyle='dotted', color=color)
        plt.plot(iters, ys, color=color)
    plt.legend([
        '$x,\\, \\gamma=0.5$', '$y(x),\\, \\gamma=0.5$',
        '$x,\\, \\gamma=1$', '$y(x),\\, \\gamma=1$',
        '$x,\\, \\gamma=3$', '$y(x),\\, \\gamma=3$'
    ])
    plt.xlabel('iterations')
    plt.show()

b_ii()
b_iii()
c(is_part_i=True)
c(is_part_i=False)
