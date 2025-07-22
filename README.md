# CoolTShirts

# 🧮 Marketing Attribution Analysis — CoolTShirts

## 📊 Overview
CoolTShirts, an innovative apparel brand, is running multi-channel marketing campaigns. This project analyzes user interactions across their digital touchpoints to determine which campaigns are most effective at both introducing users and converting them into customers.

## 🛠️ Tech Stack
- SQL 
- Data analysis using attribution modeling
- Funnel exploration

## 🎯 Objectives
- Identify how campaigns and sources influence user behavior
- Measure first- and last-touch attribution
- Understand purchase behavior
- Recommend 5 campaigns for reinvestment

## 🗃️ Dataset Schema
**Table:** `page_visits`  
| Column | Type |
|--------|------|
| page_name | TEXT |
| timestamp | TEXT |
| user_id | INTEGER |
| utm_campaign | TEXT |
| utm_source | TEXT |

## 🔍 Key Questions & Insights

### 1. Campaigns and Sources
- 8 distinct campaigns
- 6 unique sources (e.g., Google, Facebook, Email)
- Email and Google are multi-campaign platforms

### 2. Website Pages
- `1 - landing_page`, `2 - shopping_cart`, `3 - checkout`, `4 - purchase`

### 3. User Journey Analysis
- **First-touch leaders**: Medium, NYTimes, BuzzFeed
- **Last-touch converters**: Email (weekly newsletter), Facebook (retargeting ad)
- **Total purchasers**: 361

### 4. Recommended Campaigns for Reinvestment
| Campaign | Source | Reason |
|----------|--------|--------|
| weekly-newsletter | Email | Top converter (115 purchases) |
| retargetting-ad | Facebook | Strong closer (113 purchases) |
| retargetting-campaign | Email | Converts return visitors (54 purchases) |
| paid-search | Google | High intent traffic (52 purchases) |
| cool-tshirts-search | Google | Full funnel contributor |


