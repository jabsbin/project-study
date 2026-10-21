from pandas import DataFrame

data = {"a": [80, 90, 70, 30], "b": [90, 70, 60, 40], "c": [90, 60, 80, 70]}
df = DataFrame(data)
df.columns = ["국어", "영어", "수학"]

print(df["수학"])
print()
print(df["수학"].std())
print()
print(df[["국어", "영어"]])