import sympy as sp
import sympy.plotting as plt

# (i)
x = sp.symbols('x')
y = x**4
dydx = sp.diff(y, x)
print(dydx)

# (ii) and (iii)
def compare_plots(x, dydx, deltas):
    colors = ['b', 'r', 'g', 'c', 'm']
    plot_range = (x, -2, 2)
    plots = plt.plot(dydx, plot_range, show=False, label='sympy', line_color=colors[0])
    for delta, color in zip(deltas, colors[1:]):
        dydx_estimate = ((x + delta)**4 - x**4) / delta
        plot = plt.plot(dydx_estimate, plot_range, show=False, label=f'delta={delta}', line_color=color)
        plots.append(plot[0])
    plots.legend = True
    plots.show()

# (ii)
compare_plots(x, dydx, [0.01])

# (iii)
compare_plots(x, dydx, [0.001, 0.01, 0.1, 1])
