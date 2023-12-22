import numpy as np
import matplotlib.pyplot as plt
from matplotlib.animation import FuncAnimation
from scipy import ndimage

# Define the grid and initial condition
n = 300
x = np.linspace(-1.5, 1.5, n)
y = np.linspace(-1.5, 1.5, n)
x_grid, y_grid = np.meshgrid(x, y)
distance_grid = np.sqrt(x_grid**2 + y_grid**2)
u = np.zeros((n, n))

# Create a figure and axis for the initial plot
plt.figure()
plt.imshow(u)
plt.colorbar()
plt.title('Unsteady Heat Equation (Non-Zero Initial Conditions)')
plt.xlabel('X')
plt.ylabel('Y')

# Function to update the plot data in each frame
def update(frame):
    global u
    u[(distance_grid > 1) & (x_grid < 0)] = 1
    u[(distance_grid > 1) & (x_grid >= 0)] = 2
    lu = ndimage.laplace(u)
    u[1:299, 1:299] = u[1:299, 1:299] + lu[1:299, 1:299]
    plt.clf()  # Clear the previous plot
    plt.imshow(u)
    plt.colorbar()
    plt.title(f'Iteration {frame}')
    plt.xlabel('X')
    plt.ylabel('Y')

# Create the animation
anim = FuncAnimation(plt.gcf(), update, frames=range(1000), repeat=False)

# Display the animation
plt.show()
