# 🧹 2. Data Cleaning

## Overview
This section focuses on essential data cleaning techniques used in real-world data analysis. Learn to handle missing values, remove duplicates, clean strings, and validate data types - critical skills for preparing data for analysis.

## 📁 Contents

```
2 Data Cleaning/
├── 07_Missing_Values.ipynb
├── 08_Duplicates_and_Data_Consistency.ipynb
├── 09_String_Cleaning.ipynb
├── 10_Data_Type_Validation.ipynb
├── 07_missing_data.csv
├── 08_duplicates_data.csv
├── 09_string_cleaning.csv
└── 10_datatype_validation.csv
```

## 📚 Notebooks

### 07. Missing Values
**Topics:**
- Detecting standard missing values (NaN, None)
- Identifying non-standard missing values (?, Unknown, empty strings)
- Imputation strategies (mean, median, mode, forward/backward fill)
- Dropping vs filling missing values
- Impact analysis of missing data

**Key Operations:**
```python
# Detection
df.isnull().sum()                    # Count missing values
df.isna()                            # Boolean mask

# Handling non-standard missing
df.replace(["?", "Unknown", " "], np.nan)

# Imputation
df.fillna(df.mean())                 # Fill with mean
df.fillna(method='ffill')            # Forward fill
df.fillna(method='bfill')            # Backward fill
df.dropna()                          # Remove rows
df.dropna(subset=['column'])         # Drop based on column
```

**Dataset:** `07_missing_data.csv`
- Contains: Standard NaN, "?", "Unknown", empty strings
- Columns: name, gender, age, salary, city, date of joining
- Challenge: Mixed missing value representations

**Learning Outcomes:**
- Detect all types of missing values
- Choose appropriate imputation strategies
- Understand impact on data types
- Preserve data integrity

---

### 08. Duplicates and Data Consistency
**Topics:**
- Identifying exact duplicates
- Detecting partial duplicates
- Handling case sensitivity issues
- Managing whitespace in duplicate detection
- Business logic for duplicate resolution

**Key Operations:**
```python
# Detection
df.duplicated().sum()                           # Count duplicates
df.duplicated(keep=False)                       # Show all duplicates
df[df.duplicated(keep=False)].sort_values('name')

# Removal
df.drop_duplicates()                            # Remove exact duplicates
df.drop_duplicates(keep='first')                # Keep first occurrence
df.drop_duplicates(subset=['name'])             # Based on columns

# Normalization for hidden duplicates
df['name'] = df['name'].str.lower()             # Case normalization
df['city'] = df['city'].str.strip()             # Whitespace removal
```

**Dataset:** `08_duplicates_data.csv`
- Contains: Exact duplicates, case variations, whitespace issues
- Columns: name, gender, age, salary, city, date of joining
- Challenge: Hidden duplicates (case, whitespace)

**Duplicate Types:**
1. **Exact**: Identical rows
2. **Partial**: Same key fields, different values
3. **Hidden**: Case/whitespace variations
4. **Logical**: Same entity, different representations

**Learning Outcomes:**
- Identify all duplicate types
- Apply normalization techniques
- Implement business rules
- Maintain data integrity

---

### 09. String Cleaning
**Topics:**
- Whitespace trimming
- Case normalization
- Removing special characters
- Pattern matching with regex
- Standardizing spelling
- Cleaning numerical strings

**Key Operations:**
```python
# Whitespace handling
df['name'] = df['name'].str.strip()             # Remove leading/trailing
df['city'] = df['city'].str.lstrip()            # Remove leading
df['city'] = df['city'].str.rstrip()            # Remove trailing

# Case normalization
df['city'] = df['city'].str.lower()             # Lowercase
df['city'] = df['city'].str.upper()             # Uppercase
df['city'] = df['city'].str.title()             # Title Case
df['city'] = df['city'].str.capitalize()        # Capitalize first

# Pattern removal with regex
df['salary'] = df['salary'].str.replace(r'[\$,/-]', '', regex=True)
df['name'] = df['name'].str.replace(r'^(Mr|Mrs)\.?\s+', '', regex=True)

# Standardization
df['city'] = df['city'].str.replace('Kolkatta', 'Kolkata')
```

**Dataset:** `09_string_cleaning.csv`
- Contains: Whitespace, mixed case, formatted numbers, typos
- Columns: name, gender, age, salary, city, date of joining
- Challenge: Multiple string formatting issues

**Common Issues:**
- Leading/trailing spaces: " Amit ", "Pune  "
- Case inconsistency: "KOLKATA", "pune"
- Formatted numbers: "$40,769", "77,819"
- Spelling errors: "Kolkatta" → "Kolkata"

**Learning Outcomes:**
- Clean text data systematically
- Use regex for pattern matching
- Normalize case and formatting
- Fix spelling variations

---

### 10. Data Type Validation
**Topics:**
- Detecting data type issues
- Converting string to numeric types
- Handling mixed-type columns
- Date parsing and standardization
- Boolean type conversion
- Memory optimization

**Key Operations:**
```python
# Type inspection
df.dtypes                                       # Check types
df.info()                                       # Detailed info
df.memory_usage(deep=True)                      # Memory usage

# Numeric conversion
pd.to_numeric(df['age'], errors='coerce')       # Convert with error handling
df['age'] = df['age'].astype('Int64')           # Nullable integer
df['salary'] = df['salary'].astype('float32')   # Memory-efficient

# String cleaning before conversion
df['age'] = df['age'].str.replace(' years', '')
df['salary'] = df['salary'].str.replace(r'[$,]', '', regex=True)

# Date conversion
pd.to_datetime(df['date'], format='%d-%m-%Y')
pd.to_datetime(df['date'], infer_datetime_format=True)

# Boolean conversion
df['is_full_time'] = df['is_full_time'].map({'TRUE': True, 'Yes': True})

# Memory optimization
df['gender'] = df['gender'].astype('category')
df['age'] = df['age'].astype('int8')
```

**Dataset:** `10_datatype_validation.csv`
- Contains: Mixed types, formatted numbers, inconsistent booleans
- Columns: name, gender, age, salary, city, date of joining, is_full_time
- Challenge: Type conversion with data cleaning

**Type Issues:**
- Age: Contains "42 years" (text suffix)
- Salary: Contains "$93707", "96,101" (formatting)
- Boolean: "TRUE", "Yes", "1" (inconsistent)

**Learning Outcomes:**
- Validate and convert data types
- Handle conversion errors gracefully
- Optimize memory usage
- Standardize boolean representations

---

## 📊 Datasets Summary

| Dataset | Size | Issues | Focus |
|---------|------|--------|-------|
| 07_missing_data.csv | 810 bytes | Missing values | NaN handling |
| 08_duplicates_data.csv | 1.1 KB | Duplicates | Deduplication |
| 09_string_cleaning.csv | 875 bytes | String issues | Text cleaning |
| 10_datatype_validation.csv | 977 bytes | Type issues | Type conversion |

---

## 🎯 Learning Path

**Recommended Order:**
1. **07 - Missing Values**: Foundation of data quality
2. **08 - Duplicates**: Ensure data uniqueness
3. **09 - String Cleaning**: Normalize text data
4. **10 - Type Validation**: Correct data types

**Time Estimate:** 6-8 hours

---

## 💡 Data Quality Framework

### The 6 Dimensions of Data Quality

| Dimension | Description | Notebook |
|-----------|-------------|----------|
| **Completeness** | No missing values | 07 |
| **Uniqueness** | No duplicates | 08 |
| **Consistency** | Standardized formats | 08, 09 |
| **Accuracy** | Correct data types | 10 |
| **Validity** | Values within ranges | 10 |
| **Timeliness** | Up-to-date data | All |

---

## 🔍 Common Data Quality Issues

| Issue | Detection | Solution | Notebook |
|-------|-----------|----------|----------|
| Missing values | `.isnull().sum()` | Imputation/removal | 07 |
| Exact duplicates | `.duplicated()` | `.drop_duplicates()` | 08 |
| Case variations | `.str.lower()` | Normalize case | 08, 09 |
| Whitespace | `.str.strip()` | Trim whitespace | 09 |
| Wrong types | `.dtypes` | `pd.to_numeric()` | 10 |
| Formatted numbers | Regex patterns | `.str.replace()` | 09, 10 |

---

## 🛠️ Best Practices

### 1. Always Inspect First
```python
df.info()                    # Check types and nulls
df.describe()                # Statistical summary
df.head(20)                  # View sample
df['column'].unique()        # Check unique values
df['column'].value_counts()  # Frequency distribution
```

### 2. Document Changes
```python
print(f"Original shape: {df.shape}")
df = df.dropna()
print(f"After removing nulls: {df.shape}")
```

### 3. Validate Results
```python
assert df.isnull().sum().sum() == 0, "Still have missing values!"
assert df.duplicated().sum() == 0, "Still have duplicates!"
```

### 4. Use Error Handling
```python
df['age'] = pd.to_numeric(df['age'], errors='coerce')
df['date'] = pd.to_datetime(df['date'], errors='coerce')
```

### 5. Create Reusable Functions
```python
def clean_numeric_column(series):
    """Remove formatting and convert to numeric"""
    return pd.to_numeric(
        series.str.replace(r'[\$,]', '', regex=True),
        errors='coerce'
    )
```

---

## 📈 Data Cleaning Workflow

```
1. DATA PROFILING
   ↓
2. MISSING VALUE HANDLING (Notebook 07)
   ↓
3. DUPLICATE REMOVAL (Notebook 08)
   ↓
4. STRING CLEANING (Notebook 09)
   ↓
5. TYPE VALIDATION (Notebook 10)
   ↓
6. VALIDATION & DOCUMENTATION
```

---

## 🚀 Next Steps

After completing this section, you'll be ready for:
- **Section 3**: Mini Project - Apply all cleaning techniques
- **Section 4**: Advanced Pandas operations
- Real-world data preprocessing projects

---

## 📖 Quick Reference

```python
# Missing Values
df.isnull().sum()
df.fillna(df.mean())
df.dropna()

# Duplicates
df.duplicated().sum()
df.drop_duplicates()

# String Cleaning
df['col'].str.strip()
df['col'].str.lower()
df['col'].str.replace(pattern, replacement)

# Type Conversion
pd.to_numeric(df['col'], errors='coerce')
pd.to_datetime(df['col'])
df['col'].astype('category')
```

---

**Status:** ✅ Data Cleaning Complete  
**Next:** 🎯 Mini Project - Data Cleaning  
**Level:** Intermediate → Advanced