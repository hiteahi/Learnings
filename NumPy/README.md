# NumPy

A comprehensive collection of Jupyter notebooks covering essential NumPy concepts for data science and machine learning. This series provides hands-on examples and practical demonstrations of NumPy's core functionality.

---

## Overview

This portfolio demonstrates proficiency in NumPy, the fundamental package for scientific computing in Python. Each notebook focuses on a specific concept with clear explanations, code examples, and real-world applications.

---

## Table of Contents

| # | Notebook | Topics Covered | Key Concepts |
|---|----------|----------------|--------------|
| 01 | [Why NumPy vs Python List](./01_Why_NumPy_vs_Python_List.ipynb) | Performance comparison, Memory efficiency | Vectorization, Speed benchmarks |
| 02 | [Creating NumPy Arrays](./02_Creating_NumPy_Arrays.ipynb) | Array initialization methods | zeros, ones, arange, linspace |
| 03 | [Data Types in NumPy](./03_Data_Types_in_NumPy.ipynb) | Type system, Type conversion | int32, float64, dtype, astype |
| 04 | [Indexing and Slicing](./04_Indexing_and_Slicing_in_NumPy.ipynb) | Data access patterns | Fancy indexing, Boolean masking |
| 05 | [Multidimensional Arrays](./05_Multidimensional_Arrays_and_Axis.ipynb) | Multi-axis operations | axis parameter, ndim, shape |
| 06 | [View vs Copy](./06_View_vs_Copy.ipynb) | Memory management | Shallow vs deep copy, .base |
| 07 | [Broadcasting](./07_Broadcasting_in_NumPy.ipynb) | Shape compatibility rules | Broadcasting rules, Vectorization |

---

##  Learning Path

### Beginner Level
1. **Start here**: `01_Why_NumPy_vs_Python_List.ipynb` - Understand why NumPy is essential
2. **Array Creation**: `02_Creating_NumPy_Arrays.ipynb` - Learn different ways to create arrays
3. **Data Types**: `03_Data_Types_in_NumPy.ipynb` - Master NumPy's type system

### Intermediate Level
4. **Data Access**: `04_Indexing_and_Slicing_in_NumPy.ipynb` - Efficient data manipulation
5. **Multi-dimensional**: `05_Multidimensional_Arrays_and_Axis.ipynb` - Work with complex data structures
6. **Memory Management**: `06_View_vs_Copy.ipynb` - Understand memory efficiency

### Advanced Level
7. **Broadcasting**: `07_Broadcasting_in_NumPy.ipynb` - Master advanced array operations

---

## Key Learning Outcomes

After completing this series, you will be able to:

- Understand why NumPy is faster and more memory-efficient than Python lists
- Create and initialize NumPy arrays using various methods
- Work with different data types and optimize memory usage
- Efficiently access and manipulate array data using indexing and slicing
- Perform operations on multidimensional arrays with axis parameters
- Manage memory effectively using views and copies
- Apply broadcasting rules for efficient array operations

---

## Highlights

### Performance Comparison
```python
# Python List: ~2.5 seconds for 10M operations
# NumPy Array: ~0.05 seconds for 10M operations
# 50x faster!
```

### Memory Efficiency
```python
# Python List: 8000 bytes for 1000 integers
# NumPy Array: 4000 bytes for 1000 integers
# 50% less memory!
```

### Vectorization Power
```python
# Python: [x**3 for x in list]  # Slow loop
# NumPy: array**3                # Fast vectorized operation
```

---

## Technologies Used

- **Python 3.x**
- **NumPy** - Numerical computing library
- **Jupyter Notebook** - Interactive development environment

---

## Structure

```
numpy-fundamentals/
│
├── README.md                                    # This file
├── 01_Why_NumPy_vs_Python_List.ipynb           # Performance & efficiency
├── 02_Creating_NumPy_Arrays.ipynb              # Array initialization
├── 03_Data_Types_in_NumPy.ipynb                # Type system
├── 04_Indexing_and_Slicing_in_NumPy.ipynb     # Data access
├── 05_Multidimensional_Arrays_and_Axis.ipynb  # Multi-axis operations
├── 06_View_vs_Copy.ipynb                       # Memory management
└── 07_Broadcasting_in_NumPy.ipynb              # Advanced operations
```
---

## Use Cases Demonstrated

- **Data Science**: Efficient data manipulation and analysis
- **Machine Learning**: Feature matrix operations and transformations
- **Scientific Computing**: Numerical computations and simulations
- **Image Processing**: Multi-dimensional array operations
- **Statistical Analysis**: Vectorized mathematical operations

---

## Best Practices Covered

1. **Memory Optimization**: Using appropriate data types (int32 vs int64)
2. **Performance**: Leveraging vectorization over loops
3. **Code Clarity**: Using meaningful variable names and comments
4. **Error Prevention**: Understanding view vs copy behavior
5. **Efficiency**: Applying broadcasting instead of explicit loops

---

## Contributing
This is a personal learning portfolio, but suggestions and feedback are welcome!


*Made with ❤️*