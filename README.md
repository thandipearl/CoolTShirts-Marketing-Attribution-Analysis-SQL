

#  Marketing Attribution Analysis — CoolTShirts

##  Overview
CoolTShirts is an innovative apparel shop specializing in T-shaped shirts. The company recently launched a variety of marketing campaigns across multiple digital channels and wants to optimize its marketing budget based on how users interact with their website.

This project performs a marketing attribution analysis to answer the following:
- Which campaigns and sources are bringing users to the site?
- Which campaigns are best at converting users into purchasers?
- What is the typical user journey?
- Which 5 campaigns should CoolTShirts reinvest in?

##  Tech Stack
- SQL (SQLite)
- Attribution modeling (first-touch and last-touch)
- Funnel analysis

## 🗃️ Dataset Schema
**Table:** `page_visits`

| Column        | Type   |
|---------------|--------|
| page_name     | TEXT   |
| timestamp     | TEXT   |
| user_id       | INTEGER|
| utm_campaign  | TEXT   |
| utm_source    | TEXT   |

Total rows: 5,692

---

##  Project Goals

1. Understand campaign and source performance.
2. Attribute value to campaigns across the user funnel.
3. Recommend the top 5 campaigns for reinvestment.

---

##  Key Findings and Actionable Insights

###  Campaign and Source Overview
- **Campaigns used:** 8  
- **Sources used:** 6  
- **Campaign–Source mapping:**

| utm_source | utm_campaign                          |
|------------|----------------------------------------|
| buzzfeed   | ten-crazy-cool-tshirts-facts          |
| email      | retargetting-campaign                 |
| email      | weekly-newsletter                     |
| facebook   | retargetting-ad                       |
| google     | cool-tshirts-search                   |
| google     | paid-search                           |
| medium     | interview-with-cool-tshirts-founder   |
| nytimes    | getting-to-know-cool-tshirts          |

 **Insight:** Email and Google are used for multiple campaigns, indicating potential for channel segmentation and A/B testing across audiences.

---

### 📄 Website Page Structure
- `1 - landing_page`
- `2 - shopping_cart`
- `3 - checkout`
- `4 - purchase`

This structure represents a standard 4-step purchase funnel.

---

###  First Touch Attribution (Brand Discovery)

| Source   | Campaign                            | First Touches |
|----------|-------------------------------------|----------------|
| medium   | interview-with-cool-tshirts-founder | **622**        |
| nytimes  | getting-to-know-cool-tshirts        | **612**        |
| buzzfeed | ten-crazy-cool-tshirts-facts        | **576**        |
| google   | cool-tshirts-search                 | 169            |

 **Insight:** Editorial-style content on **Medium, NYTimes, and BuzzFeed** is effective at **attracting new visitors**.

---

###  Last Touch Attribution (Conversions)

| Source   | Campaign              | Last Touches |
|----------|-----------------------|----------------|
| email    | weekly-newsletter     | **447**        |
| facebook | retargetting-ad       | **443**        |
| email    | retargetting-campaign | **245**        |
| nytimes  | getting-to-know-cool-tshirts | 232     |
| buzzfeed | ten-crazy-cool-tshirts-facts | 190     |
| medium   | interview-with-cool-tshirts-founder | 184 |
| google   | paid-search           | 178            |
| google   | cool-tshirts-search   | 60             |

 **Insight:** Email campaigns and Facebook retargeting ads are **strongest at closing**. These should be prioritized for conversion optimization and scaling.

---

###  Purchase Attribution (Direct Last-Touch on `4 - purchase` Page)

| Source   | Campaign              | Purchases |
|----------|-----------------------|------------|
| email    | weekly-newsletter     | **115**    |
| facebook | retargetting-ad       | **113**    |
| email    | retargetting-campaign | 54         |
| google   | paid-search           | 52         |
| buzzfeed | ten-crazy-cool-tshirts-facts | 9    |
| nytimes  | getting-to-know-cool-tshirts | 9    |
| medium   | interview-with-cool-tshirts-founder | 7 |
| google   | cool-tshirts-search   | 2          |

 **Insight:** Over **90% of purchases** came from just 4 campaigns — again, showing **email and retargeting strength**.

---

### 🔄 User Journey Examples

Here are sample user journeys from a few visitors:

| user_id | Journey |
|---------|---------|
| 10030   | 1 - landing_page → 2 - shopping_cart → 3 - checkout → 4 - purchase |
| 10069   | 1 - landing_page → 2 - shopping_cart → 3 - checkout → 4 - purchase |
| 10162   | 1 - landing_page → 2 - shopping_cart → 3 - checkout → 4 - purchase |
| 10329   | 1 - landing_page → 2 - shopping_cart → 3 - checkout → 4 - purchase |

 **Insight:** Funnel is functioning well, but **not all users reach the purchase step**. Focus on improving **checkout completion** rates.

---

##  Top 5 Campaigns for Reinvestment

| Campaign              | Source   | Why Reinvest?                            |
|-----------------------|----------|------------------------------------------|
| weekly-newsletter     | email    | #1 in purchases (115) + highest last-touch |
| retargetting-ad       | facebook | #2 in purchases (113) + strong conversions |
| retargetting-campaign | email    | Consistent closer for returning users     |
| paid-search           | google   | High intent users (52 purchases)          |
| cool-tshirts-search   | google   | Supports both awareness and conversion    |

---

##  Lessons Learned

- Top-of-funnel awareness is driven by **editorial content**, especially through Medium and NYTimes.
- Email and retargeting campaigns perform **best at converting** users to purchasers.
- Conversion can be further improved by optimizing the **checkout process** and **testing messaging** on purchase pages.

---

## 💻 Sample SQL Snippets

```sql
-- Count distinct campaigns
SELECT COUNT(DISTINCT utm_campaign) FROM page_visits;

-- First-touch attribution
WITH first_touch AS (
  SELECT user_id, MIN(timestamp) AS first_touch_at
  FROM page_visits GROUP BY user_id
),
ft_attr AS (
  SELECT ft.user_id, ft.first_touch_at, pv.utm_source, pv.utm_campaign
  FROM first_touch ft
  JOIN page_visits pv ON ft.user_id = pv.user_id AND ft.first_touch_at = pv.timestamp
)
SELECT utm_source, utm_campaign, COUNT(*) AS first_touches
FROM ft_attr GROUP BY 1, 2 ORDER BY 3 DESC;
```
-------------
Please note: The raw dataset is not available for download as this project was completed within the Codecademy workspace.
