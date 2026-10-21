import pandas as pd

df = pd.read_csv('sales_data.csv')

result = df.pivot_table(
    index='날짜', 
    columns='제품', 
    values='판매수량', 
    aggfunc='sum'
)

print(result)