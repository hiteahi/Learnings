# 📘 1. Pandas Foundations

## Overview
This section covers the fundamental concepts of Pandas, providing a solid foundation for data manipulation and analysis. These notebooks introduce core data structures, file operations, data selection, and filtering techniques.

## 📁 Contents

```
1 Pandas Foundations/
├── 01_Introduction_to_Pandas.ipynb
├── 02_Pandas_Series.ipynb
├── 03_Pandas_DataFrame.ipynb
├── 04_Reading_and_Writing_Data_in_Pandas.ipynb
├── 05_Data_Selection_and_Indexing_in_Pandas.ipynb
├── 06_Filtering_and_conditions.ipynb
├── 3.1_data.csv
├── 4.1_data.csv
├── 4.2_data.csv
└── sample_data.csv
```

## 📚 Notebooks

### 01. Introduction to Pandas
**Topics:**
- What is Pandas and why use it?
- Pandas vs Excel, SQL, and NumPy
- Core data structures overview
- Installation and setup

**Learning Outcomes:**
- Understand Pandas ecosystem
- Know when to use Pandas
- Recognize Pandas advantages

---

### 02. Pandas Series
**Topics:**
- Creating Series from lists and dictionaries
- Index labels and custom indexing
- Series operations and alignment
- Handling missing values (NaN)

**Key Operations:**
```python
# Creating Series
s = pd.Series([11, 22, 33, 44])
s = pd.Series({'Apple': 120, 'Banana': 60})

# Operations
s1 + s2  # Automatic alignment by index
s.mean(), s.sum(), s.max()
```

**Learning Outcomes:**
- Create and manipulate 1D data structures
- Work with labeled indices
- Perform vectorized operations

---

### 03. Pandas DataFrame
**Topics:**
- Creating DataFrames from various sources
- Index and column management
- Basic inspection methods
- DataFrame properties

**Key Operations:**
```python
# Creating DataFrames
df = pd.DataFrame(data)
df = pd.read_csv('file.csv')

# Inspection
df.head(), df.tail()
df.info(), df.describe()
df.shape, df.columns, df.index
```

**Learning Outcomes:**
- Create and inspect 2D data structures
- Understand DataFrame anatomy
- Use basic inspection methods

---

### 04. Reading and Writing Data
**Topics:**
- CSV file operations
- Excel file handling
- JSON data processing
- Memory optimization techniques
- Advanced read_csv parameters

**Key Parameters:**
```python
# Reading with options
pd.read_csv('file.csv',
    sep=';',              # Custom delimiter
    header=1,             # Skip rows
    index_col=0,          # Set index
    usecols=['col1'],     # Select columns
    dtype={'col': 'int8'} # Optimize types
)

# Writing
df.to_csv('output.csv', index=False)
df.to_excel('output.xlsx')
```

**Learning Outcomes:**
- Load data from multiple formats
- Optimize memory usage
- Export processed data

---

### 05. Data Selection and Indexing
**Topics:**
- Column selection
- Row selection with iloc (position-based)
- Row selection with loc (label-based)
- Fast access with at and iat

**Key Operations:**
```python
# Column selection
df['column']           # Single column (Series)
df[['col1', 'col2']]  # Multiple columns (DataFrame)

# Row selection
df.iloc[0]            # First row by position
df.loc[0]             # Row by label
df.iloc[0:5, 0:3]     # Slice by position
df.loc[0:5, ['col1']] # Slice by label

# Fast access
df.at[0, 'column']    # Single value by label
df.iat[0, 0]          # Single value by position
```

**Learning Outcomes:**
- Select data efficiently
- Understand loc vs iloc
- Use appropriate selection methods

---

### 06. Filtering and Conditions
**Topics:**
- Boolean indexing
- Multiple conditions
- Query method
- Complex filtering

**Key Operations:**
```python
# Boolean indexing
df[df['age'] > 30]
df[(df['age'] > 30) & (df['city'] == 'Delhi')]

# Query method
df.query("age > 30 and city == 'Delhi'")
df.query("age > @min_age")

# isin method
df[df['city'].isin(['Delhi', 'Mumbai'])]
```

**Learning Outcomes:**
- Filter data with conditions
- Use boolean masks
- Write SQL-like queries

---

## 📊 Datasets

### sample_data.csv
Employee dataset with demographics and salary information.
```
Columns: name, gender, age, salary, city, date of joining
Records: ~20 employees
Use: General data manipulation examples
```

### 3.1_data.csv
Student marks dataset.
```
Columns: name, city, gender, marks
Records: 5 students
Use: DataFrame creation examples
```

### 4.1_data.csv
Semicolon-delimited student data.
```
Columns: S.no., name, city, gender, marks
Delimiter: Semicolon (;)
Use: Custom delimiter handling
```

### 4.2_data.csv
Processed student data output.
```
Columns: S.no., name, gender, marks
Use: Data export examples
```

---

## 🎯 Learning Path

**Recommended Order:**
1. Start with 01 (Introduction) - Understand the ecosystem
2. Progress to 02 (Series) - Learn 1D structures
3. Move to 03 (DataFrame) - Master 2D structures
4. Continue to 04 (I/O) - Load and save data
5. Advance to 05 (Selection) - Access data efficiently
6. Complete with 06 (Filtering) - Query data effectively

**Time Estimate:** 8-10 hours

---

## 💡 Key Concepts

### Data Structures
- **Series**: 1D labeled array
- **DataFrame**: 2D labeled table (like Excel)
- **Index**: Row labels for fast access

### Selection Methods
- **iloc**: Position-based (integers)
- **loc**: Label-based (index labels)
- **at/iat**: Fast single-value access

### Best Practices
✅ Use appropriate data types for memory efficiency  
✅ Set meaningful index for faster lookups  
✅ Use vectorized operations over loops  
✅ Leverage query() for readable filtering  
✅ Always inspect data after loading  

---

## 🚀 Next Steps

After completing this section, you'll be ready for:
- **Section 2**: Data Cleaning techniques
- **Section 3**: Real-world cleaning project
- **Section 4**: Advanced Pandas operations

---

## 📖 Quick Reference

```python
# Essential Operations
df.head()              # First 5 rows
df.info()              # Column info
df.describe()          # Statistics
df.shape               # Dimensions
df['col']              # Select column
df.iloc[0]             # Select row by position
df.loc[0]              # Select row by label
df[df['age'] > 30]     # Filter rows
df.query("age > 30")   # SQL-like filter
```

---

**Status:** ✅ Foundation Complete  
**Next:** 🧹 Data Cleaning  
**Level:** Beginner → Intermediate