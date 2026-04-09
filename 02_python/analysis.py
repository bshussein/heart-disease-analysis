import pandas as pd
import numpy as np
from pathlib import Path
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import classification_report

# Define column names for the dataset
columns = [
    "age", "age_group", "sex", "cp", "trestbps", "chol",
    "thalach", "exang", "oldpeak", "slope",
    "ca", "thal", "target", "source"
]
# =========================
# 1. Load the Dataset
# =========================
df = pd.read_csv("Data/heart_features.csv", header=None, names=columns)

print(df.head())
print(df.info())

# =========================
# 2. Explore Missing Values
# =========================
print("\nMissing Values:\n")
print(df.isnull().sum())

# =========================
# 3. Handle Missing Values
# =========================

# Drop columns with too many missing values
df = df.drop(columns=['ca', 'thal'])

# Fill numerical columns with median
df['trestbps'] = df['trestbps'].fillna(df['trestbps'].median())
df['chol'] = df['chol'].fillna(df['chol'].median())
df['thalach'] = df['thalach'].fillna(df['thalach'].median())
df['exang'] = df['exang'].fillna(df['exang'].median())
df['oldpeak'] = df['oldpeak'].fillna(df['oldpeak'].median())
df['slope'] = df['slope'].fillna(df['slope'].median())

print("\nMissing Values After Cleaning:\n")
print(df.isnull().sum())

# =========================
# 4. Feature Engineering
# =========================

# Create high cholesterol flag
df['high_chol'] = np.where(df['chol'] > 240, 1, 0)

# Create high blood pressure flag
df['high_bp'] = np.where(df['trestbps'] > 140, 1, 0)

# Create heart rate category
df['high_hr'] = np.where(df['thalach'] > df['thalach'].median(), 1, 0)

print("\nNew Columns Added:\n")
print(df[['high_chol', 'high_bp', 'high_hr']].head())

# =========================
# 5. Quick Analysis
# =========================

print("\nDisease Rate by Age Group:\n")
print(df.groupby('age_group')['target'].mean())

print("\nDisease Rate by Sex:\n")
print(df.groupby('sex')['target'].mean())

print("\nDisease Rate by Chest Pain:\n")
print(df.groupby('cp')['target'].mean())

# =========================
# 6. Prepare Data for Model
# =========================

# Drop non-numeric columns for modeling
df_model = df.drop(columns=['age_group', 'source'])

X = df_model.drop(columns=['target'])
y = df_model['target']

# Train/test split
X_train, X_test, y_train, y_test = train_test_split(
    X, y, test_size=0.2, random_state=42
)

# Train model
model = LogisticRegression(max_iter=1000)
model.fit(X_train, y_train)

# Evaluate model
y_pred = model.predict(X_test)

print("\nModel Performance:\n")
print(classification_report(y_test, y_pred))

# coefficients for feature importance
coefficients = pd.DataFrame({
    'Feature': X.columns,
    'Importance': model.coef_[0]
}).sort_values(by='Importance', ascending=False)

print("\nFeature Importance:\n")
print(coefficients)

# =========================
# 7. Export Final Dataset
# =========================

final_path = Path(__file__).resolve().parent.parent / "Data" / "heart_final.csv"
df.to_csv(final_path, index=False)

print(f"\nFinal dataset exported to: {final_path}")
print(f"Shape: {df.shape}")
print(f"Columns: {list(df.columns)}")