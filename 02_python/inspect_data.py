import pandas as pd

df = pd.read_csv("../Data/heart_raw.csv")

print(df.head())

print("\nINFO:\n")
print(df.info())

print("\nDESCRIBE:\n")
print(df.describe())

print("\nNULL VALUES:\n")
print(df.isnull().sum())

print("\nTarget Distribution:\n")
print(df['target'].value_counts())

print("\nUnique values per column:\n")
for col in df.columns:
    print(col, df[col].unique())