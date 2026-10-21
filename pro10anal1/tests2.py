import numpy as np
import pandas as pd

data = np.random.randn(9, 4)
df = pd.DataFrame(data, columns=["가격1", "가격2", "가격3", "가격4"])

print(df)

print(df.mean())
