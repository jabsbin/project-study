import numpy as np
import matplotlib.pyplot as plt
import koreanize_matplotlib

data = np.random.normal(0, 1, 1000)

plt.hist(data, bins=20, alpha=0.7)
plt.title('good')
plt.show()