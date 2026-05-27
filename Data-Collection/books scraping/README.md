# Books Data Collection

A simple web scraping project that collects book information from [Books to Scrape](https://books.toscrape.com).

## What It Does

Scrapes book data including:
- **Title** - Book name
- **Price** - Price in GBP (£)
- **Rating** - Star rating (1-5)

---

## Structure

```
books scraping/
├── book_data_collection.ipynb    # Main notebook
├── books.csv                      # Output data
└── htmls/                         # Downloaded HTML pages
```

---

## How to Run

1. Install required libraries:
```bash
pip install requests beautifulsoup4 pandas
```

2. Open and run the Jupyter notebook:
```bash
jupyter notebook book_data_collection.ipynb
```

3. The script will:
   - Download 50 pages of HTML
   - Extract book information
   - Save data to `books.csv`

---

## Output

The final CSV file contains:
- **Title**: Book title
- **Price**: Price in GBP
- **Rating**: Star rating (One to Five)

---

## Key Steps

1. Check website accessibility
2. Download HTML pages
3. Parse HTML content
4. Extract book data
5. Save to CSV file

---

## Contributing

This is a personal learning portfolio, but suggestions and feedback are welcome!

*Built with ❤️*
