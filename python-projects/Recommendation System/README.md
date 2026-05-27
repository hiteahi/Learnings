# Social Network Data Analysis & Recommendation System

A Python-based project that demonstrates data cleaning, analysis, and recommendation algorithms for a social network platform. This project implements friend suggestions and page recommendations using pure Python without external machine learning libraries.

## Project Overview

This project simulates a social network platform where users can connect with friends and like pages. It includes data cleaning operations and two recommendation systems:

1. **People You May Know**: Friend recommendations based on mutual connections
2. **Pages You May Like**: Page recommendations based on friends' interests

## Project Structure

```
.
├── 1_data_loader.ipynb           # JSON data loading utilities
├── 2_data_cleaning.ipynb         # Data cleaning and preprocessing
├── 3_people_you_may_know.ipynb   # Friend recommendation algorithm
├── 4_Pages_you_may_like.ipynb    # Page recommendation algorithm
├── data.json                      # Raw social network data (with issues)
├── clean_data.json                # Cleaned and processed data
├── big_data.json                  # Extended dataset for testing
└── README.md                      # Project documentation
```

## Data Structure

### Users
Each user object contains:
- `id`: Unique user identifier
- `name`: User's name
- `friends`: List of friend IDs
- `liked_pages`: List of page IDs the user has liked

### Pages
Each page object contains:
- `id`: Unique page identifier
- `name`: Page name/title

### Sample Data
```json
{
  "users": [
    {"id": 1, "name": "Amit", "friends": [2, 3], "liked_pages": [101]},
    {"id": 2, "name": "Priya", "friends": [1, 4], "liked_pages": [102]}
  ],
  "pages": [
    {"id": 101, "name": "Python Developers"},
    {"id": 102, "name": "Data Science Enthusiasts"}
  ]
}
```

## Data Quality Issues Addressed

The raw data (`data.json`) contains several quality issues that are cleaned in notebook 2:

1. **Users Without Names**: Empty name fields
2. **Duplicate Friends**: Same friend ID appearing multiple times
3. **Inactive Users**: Users with no friends and no liked pages
4. **Duplicate Pages**: Pages with identical IDs but different names

## Notebooks Overview

### 1. Data Loader (`1_data_loader.ipynb`)
- Implements JSON data loading functionality
- Provides utility functions to read social network data
- Displays raw data structure

**Key Function:**
```python
def data_load(fname):
    with open(fname) as file:
        data = json.load(file)
    return data
```

### 2. Data Cleaning (`2_data_cleaning.ipynb`)
Cleans the raw data by:
- Removing users without names
- Eliminating duplicate friend entries
- Filtering out inactive users (no friends, no liked pages)
- Removing duplicate pages
- Saving cleaned data to `clean_data.json`

**Data Quality Improvements:**
- Before: 5 users, 5 pages (with duplicates and issues)
- After: 3 active users, 4 unique pages

### 3. People You May Know (`3_people_you_may_know.ipynb`)
Implements a friend recommendation algorithm based on:
- **Mutual Connections**: Suggests friends-of-friends
- **Connection Strength**: Ranks suggestions by number of mutual friends
- **Filtering**: Excludes existing friends and the user themselves

**Algorithm Logic:**
1. Find all friends of the user's friends
2. Count mutual connections for each potential friend
3. Rank suggestions by mutual connection count
4. Return top recommendations

### 4. Pages You May Like (`4_Pages_you_may_like.ipynb`)
Implements a page recommendation system based on:
- **Friend Interests**: Analyzes pages liked by user's friends
- **Popularity Score**: Counts how many friends like each page
- **Filtering**: Excludes pages already liked by the user

**Algorithm Logic:**
1. Collect all pages liked by user's friends
2. Count frequency of each page
3. Rank pages by popularity among friends
4. Return top recommendations

## Key Features

- **Pure Python Implementation**: No external ML libraries required
- **Scalable Algorithms**: Works with datasets of varying sizes
- **Data Quality Focus**: Comprehensive data cleaning pipeline
- **Modular Design**: Each notebook focuses on a specific task

## Use Cases

This project demonstrates practical applications in:
- Social network platforms (Facebook, LinkedIn, Twitter)
- E-commerce recommendation systems
- Content discovery platforms
- Community building applications
- Data cleaning and preprocessing workflows

## Learing Outcomes

By working through this project, you'll learn:
- JSON data handling in Python
- Data cleaning and preprocessing techniques
- Graph-based algorithms for social networks
- Recommendation system fundamentals
- Python programming best practices

## Skills Demonstrated

- **Python Programming**: Core Python, JSON handling, data structures
- **Data Analysis**: Data cleaning, preprocessing, quality assurance
- **Algorithm Design**: Graph algorithms, recommendation systems
- **Problem Solving**: Handling real-world data quality issues


**Built with Python** 🐍 ❤️ 