# 🚀 4. ADVANCED

## Overview
This section covers **advanced Pandas techniques** used by senior data analysts and data scientists. Master complex operations including grouping, aggregations, multi-table operations, pivot tables, data reshaping, sorting/ranking, and time series analysis.

## 📁 Contents

```
04 ADVANCED/
├── 01_GroupBy_and_Aggregations.ipynb
├── Data.csv
├── Merging_and_Joining_Data.ipynb
├── Pivot_Table.ipynb
├── Reshaping_Data.ipynb
├── Sorting_and_Ranking.ipynb
├── Time_Series.ipynb
└── time_series_data.csv
```

---

## 📚 Notebooks

### 01. GroupBy and Aggregations
**Topics:**
- Basic GroupBy operations
- Single and multiple column grouping
- Common aggregation functions (mean, sum, count, min, max)
- Multiple aggregations simultaneously
- Custom aggregation functions
- Named aggregations
- GroupBy with filtering

**Key Operations:**
```python
# Basic grouping
df.groupby('department')['salary'].mean()

# Multiple aggregations
df.groupby('department')['salary'].agg(['mean', 'sum', 'count'])

# Multiple columns
df.groupby(['department', 'city'])['salary'].mean()

# Named aggregations
df.groupby('department').agg(
    avg_salary=('salary', 'mean'),
    total_employees=('salary', 'count'),
    max_salary=('salary', 'max')
)

# Custom functions
df.groupby('department')['salary'].agg(lambda x: x.max() - x.min())
```

**Business Use Cases:**
- Department-wise salary analysis
- City-based employee distribution
- Revenue analysis by product category
- Customer segmentation metrics

**Learning Outcomes:**
- Perform complex aggregations
- Group by multiple dimensions
- Create custom aggregation functions
- Generate analytical summaries

---

### Merging and Joining Data
**Topics:**
- SQL-style joins (inner, left, right, outer)
- Merging on single and multiple keys
- Handling duplicate column names
- Indicator columns for merge tracking
- Concatenating DataFrames
- Combining datasets with different structures

**Key Operations:**
```python
# Inner Join - Only matching records
pd.merge(df1, df2, on='emp_id', how='inner')

# Left Join - All from left, matching from right
pd.merge(df1, df2, on='emp_id', how='left')

# Right Join - All from right, matching from left
pd.merge(df1, df2, on='emp_id', how='right')

# Outer Join - All records from both
pd.merge(df1, df2, on='emp_id', how='outer')

# Different column names
pd.merge(df1, df2, left_on='emp_id', right_on='employee_id')

# With indicator
pd.merge(df1, df2, on='emp_id', how='outer', indicator=True)

# Concatenate vertically
pd.concat([df1, df2], axis=0)

# Concatenate horizontally
pd.concat([df1, df2], axis=1)
```

**Real-World Scenarios:**
- Combining employee data with salary information
- Merging customer data with transaction history
- Joining product details with inventory data
- Integrating data from multiple sources

**Learning Outcomes:**
- Combine multiple datasets
- Understand different join types
- Handle merge conflicts
- Track merge results

---

### Pivot Tables
**Topics:**
- Creating basic pivot tables
- Multi-dimensional pivot tables
- Multiple aggregation functions
- Handling missing values in pivots
- Pivot table margins and subtotals
- Converting pivot tables back to flat format

**Key Operations:**
```python
# Basic pivot - Average salary by department
df.pivot_table(
    values='salary',
    index='department',
    aggfunc='mean'
)

# Two-dimensional pivot
df.pivot_table(
    values='salary',
    index='department',
    columns='city',
    aggfunc='mean'
)

# Multiple aggregations
df.pivot_table(
    values='salary',
    index='department',
    aggfunc=['mean', 'max', 'min', 'count']
)

# With margins (totals)
df.pivot_table(
    values='salary',
    index='department',
    columns='city',
    aggfunc='mean',
    margins=True
)
```

**Business Applications:**
- Financial reports by product and region
- HR dashboards by department and location
- Sales analytics across dimensions
- Executive summary tables

**Learning Outcomes:**
- Create analytical pivot tables
- Perform cross-tabulation analysis
- Generate business intelligence reports
- Reshape data for reporting

---

### Reshaping Data
**Topics:**
- Wide to long format (melt)
- Long to wide format (pivot)
- Handling duplicate entries
- Stack and unstack operations
- Transposing DataFrames
- Reshaping for visualization

**Key Operations:**
```python
# Melt (Wide → Long)
df.melt(
    id_vars=['Name'],
    value_vars=['Math', 'Science', 'English'],
    var_name='Subject',
    value_name='Score'
)

# Pivot (Long → Wide)
df.pivot(
    index='Name',
    columns='Subject',
    values='Score'
)

# Stack (columns to rows)
df.stack()

# Unstack (rows to columns)
df.unstack()

# Transpose
df.T
```

**When to Use:**
- **Melt**: Preparing data for visualization, statistical modeling
- **Pivot**: Creating summary reports, Excel-style presentation
- **Stack/Unstack**: Multi-level index manipulation

**Learning Outcomes:**
- Transform data between formats
- Prepare data for different use cases
- Handle multi-level indices
- Reshape for analysis and visualization

---

### Sorting and Ranking
**Topics:**
- Sorting by single and multiple columns
- Ascending and descending order
- Sorting by index
- Ranking methods (average, min, max, first, dense)
- Handling ties in ranking
- Percentile ranking
- Top-N and bottom-N selection

**Key Operations:**
```python
# Sort by single column
df.sort_values('salary', ascending=False)

# Sort by multiple columns
df.sort_values(['department', 'age'])

# Sort by index
df.sort_index()

# Basic ranking
df['salary_rank'] = df['salary'].rank(ascending=False)

# Dense ranking (no gaps)
df['dense_rank'] = df['salary'].rank(method='dense', ascending=False)

# Percentile ranking
df['percentile'] = df['salary'].rank(pct=True)

# Ranking within groups
df['dept_rank'] = df.groupby('department')['salary'].rank(ascending=False)

# Top N
df.nlargest(5, 'salary')

# Bottom N
df.nsmallest(5, 'salary')
```

**Ranking Methods:**
- **average**: Ties get average of ranks (default)
- **min**: Ties get minimum rank (gaps after)
- **max**: Ties get maximum rank
- **first**: Ranks assigned in order
- **dense**: Like min but no gaps

**Business Applications:**
- Employee performance ranking
- Sales leaderboards
- Customer segmentation (RFM)
- Product ranking by metrics

**Learning Outcomes:**
- Sort data effectively
- Apply different ranking methods
- Handle ties appropriately
- Identify top/bottom performers

---

### Time Series
**Topics:**
- Converting strings to datetime
- Setting datetime as index
- Date-based filtering and slicing
- Resampling (upsampling/downsampling)
- Rolling windows and moving averages
- Time-based aggregations
- Date component extraction
- Time zone handling

**Key Operations:**
```python
# Convert to datetime
df['Date'] = pd.to_datetime(df['Date'])

# Set as index
df.set_index('Date', inplace=True)

# Date-based filtering
df.loc['2026-01-05']                    # Single date
df.loc['2026-01-01':'2026-01-07']       # Date range
df.loc['2026-01']                       # Entire month

# Resampling
df.resample('W').sum()                  # Weekly totals
df.resample('M').mean()                 # Monthly averages
df.resample('Q').sum()                  # Quarterly sums

# Rolling windows
df['Revenue'].rolling(window=7).mean()  # 7-day moving average
df['Revenue'].rolling(window=30).sum()  # 30-day rolling sum

# Expanding windows
df['Revenue'].expanding().sum()         # Cumulative sum

# Extract date components
df['year'] = df.index.year
df['month'] = df.index.month
df['weekday'] = df.index.day_name()

# Shift for lag/lead
df['prev_day'] = df['Revenue'].shift(1)
df['next_day'] = df['Revenue'].shift(-1)
```

**Resampling Frequencies:**
- **D**: Daily
- **W**: Weekly
- **M**: Month end
- **Q**: Quarter end
- **Y**: Year end
- **H**: Hourly

**Business Applications:**
- Sales forecasting and trend analysis
- Financial time series analysis
- Operations demand forecasting
- Marketing campaign performance
- IoT sensor data analysis

**Learning Outcomes:**
- Handle date/time data
- Perform time-based analysis
- Calculate moving averages
- Resample time series data
- Extract temporal patterns

---

## 📊 Datasets

### Data.csv (1.8 KB)
Clean employee dataset with 19 records.
```
Columns: id, name, department, age, salary, joining_date, city
Departments: IT, SALES, HR, FINANCE
Cities: Delhi, Mumbai, Bangalore, Chennai, Pune
Use: GroupBy, merging, pivot tables, sorting, ranking
```

**Data Quality:**
✅ No missing values  
✅ No duplicates  
✅ Consistent formatting  
✅ Proper data types  

### time_series_data.csv (1.1 KB)
Daily sales data for multiple product categories.
```
Columns: Date, Product_Category, Units_Sold, Unit_Price, Revenue
Date Range: 2026-01-01 onwards
Frequency: Daily
Categories: Electronics, Clothing, Groceries
Use: Time series analysis, resampling, rolling windows
```

---

## 🎯 Learning Path

**Recommended Order:**
1. **GroupBy & Aggregations** - Foundation for analysis
2. **Merging & Joining** - Combine datasets
3. **Pivot Tables** - Create analytical reports
4. **Reshaping Data** - Transform data formats
5. **Sorting & Ranking** - Order and rank data
6. **Time Series** - Analyze temporal data

**Time Estimate:** 10-15 hours

---

## 💼 Real-World Applications

### Business Intelligence
- Executive dashboards with pivot tables
- Department and regional performance analysis
- Trend identification and forecasting
- KPI tracking and monitoring

### Financial Analysis
- Revenue analysis by product and region
- Time series analysis of financial metrics
- Portfolio performance tracking
- Risk assessment through aggregations

### HR Analytics
- Salary benchmarking across departments
- Employee distribution analysis
- Performance ranking and evaluation
- Workforce planning and forecasting

### Sales & Marketing
- Customer segmentation and RFM analysis
- Sales performance leaderboards
- Campaign effectiveness over time
- Seasonal trend analysis

---

## 🎓 Skills Demonstrated

### Data Aggregation
✅ GroupBy operations with multiple aggregations  
✅ Custom aggregation functions  
✅ Multi-level grouping  

### Data Integration
✅ SQL-style joins (inner, left, right, outer)  
✅ Merging on multiple keys  
✅ Concatenating datasets  

### Data Transformation
✅ Pivot tables and cross-tabulation  
✅ Wide-to-long and long-to-wide conversion  
✅ Stack and unstack operations  

### Data Organization
✅ Multi-column sorting  
✅ Various ranking methods  
✅ Top-N and percentile analysis  

### Time Series Analysis
✅ Datetime conversion and indexing  
✅ Resampling and aggregation  
✅ Rolling windows and moving averages  
✅ Trend analysis  

---

## 💡 Best Practices

### Performance Optimization
✅ Use vectorized operations over loops  
✅ Choose appropriate aggregation methods  
✅ Optimize memory with categorical types  
✅ Use efficient join strategies  

### Code Quality
✅ Use meaningful variable names  
✅ Add comments for complex operations  
✅ Validate results after transformations  
✅ Handle edge cases appropriately  

### Analysis Workflow
✅ Inspect data before operations  
✅ Validate merge results  
✅ Check for data loss in reshaping  
✅ Verify time series continuity  

---

## 📈 Complexity Progression

```
Difficulty Level
    ↑
    │                                    ┌────────┐
    │                              ┌────┤ Time   │
    │                        ┌────┤ Sort│ Series │
    │                  ┌────┤ Resh│ Rank└────────┘
    │            ┌────┤ Pivot│ape └────────┘
    │      ┌────┤ Merge│ Table└────────┘
    │ ┌────┤ Group│ Join└────────┘
    └─┴────┴──────┴─────┴────┴────┴────────────→
      Notebooks (Sequential)
```

---

## 🚀 Next Steps

After completing this section:
- **Apply to real projects**: Use techniques on actual datasets
- **Combine techniques**: Create complex analytical workflows
- **Optimize performance**: Learn advanced optimization
- **Visualization**: Integrate with Matplotlib, Seaborn, Plotly
- **Machine Learning**: Prepare data for ML models

---

## 📖 Quick Reference

```python
# GroupBy & Aggregations
df.groupby('col')['val'].mean()
df.groupby(['col1', 'col2']).agg(['mean', 'sum'])

# Merging & Joining
pd.merge(df1, df2, on='key', how='inner')
pd.concat([df1, df2], axis=0)

# Pivot Tables
df.pivot_table(values='val', index='row', columns='col', aggfunc='mean')

# Reshaping
df.melt(id_vars=['id'], value_vars=['col1', 'col2'])
df.pivot(index='id', columns='var', values='val')

# Sorting & Ranking
df.sort_values('col', ascending=False)
df['rank'] = df['col'].rank(method='dense')

# Time Series
df['date'] = pd.to_datetime(df['date'])
df.set_index('date').resample('M').sum()
df['ma'] = df['val'].rolling(window=7).mean()
```

---

**Status:** ✅ Advanced Techniques Complete  
**Level:** Advanced → Expert  
**Career Impact:** Senior Data Analyst / Data Scientist Ready