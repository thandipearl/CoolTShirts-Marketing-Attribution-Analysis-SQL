-- 1. Get Familiar with the Company

-- A. How many campaigns and sources does CoolTShirts use?
-- i. Count distinct campaigns:
SELECT COUNT(DISTINCT utm_campaign) AS num_campaigns
FROM page_visits;

-- ii. Count distinct sources:
SELECT COUNT(DISTINCT utm_source) AS num_sources
FROM page_visits;

-- iii. Show how sources and campaigns are related:
SELECT DISTINCT utm_source, utm_campaign
FROM page_visits
ORDER BY utm_source, utm_campaign;

-- B. What pages are on their website?
SELECT DISTINCT page_name
FROM page_visits;

-- 2. What is the User Journey?
-- A. How many first touches is each campaign responsible for?
WITH first_touch AS (
  SELECT user_id,
         MIN(timestamp) AS first_touch_at
  FROM page_visits
  GROUP BY user_id
),
ft_attr AS (
  SELECT ft.user_id,
         ft.first_touch_at,
         pv.utm_source,
         pv.utm_campaign
  FROM first_touch ft
  JOIN page_visits pv
    ON ft.user_id = pv.user_id
    AND ft.first_touch_at = pv.timestamp
)
SELECT ft_attr.utm_source,
       ft_attr.utm_campaign,
       COUNT(*) AS first_touches
FROM ft_attr
GROUP BY 1, 2
ORDER BY 3 DESC;

-- B. How many last touches is each campaign responsible for?
WITH last_touch AS (
  SELECT user_id,
         MAX(timestamp) AS last_touch_at
  FROM page_visits
  GROUP BY user_id
),
lt_attr AS (
  SELECT lt.user_id,
         lt.last_touch_at,
         pv.utm_source,
         pv.utm_campaign
  FROM last_touch lt
  JOIN page_visits pv
    ON lt.user_id = pv.user_id
    AND lt.last_touch_at = pv.timestamp
)
SELECT lt_attr.utm_source,
       lt_attr.utm_campaign,
       COUNT(*) AS last_touches
FROM lt_attr
GROUP BY 1, 2
ORDER BY 3 DESC;

-- C. How many visitors make a purchase?
SELECT COUNT(DISTINCT user_id) AS purchasers
FROM page_visits
WHERE page_name = '4 - purchase';

-- D. How many last touches on the purchase page is each campaign responsible for?
WITH last_touch AS (
  SELECT user_id,
         MAX(timestamp) AS last_touch_at
  FROM page_visits
  WHERE page_name = '4 - purchase'
  GROUP BY user_id
),
lt_attr AS (
  SELECT lt.user_id,
         lt.last_touch_at,
         pv.utm_source,
         pv.utm_campaign
  FROM last_touch lt
  JOIN page_visits pv
    ON lt.user_id = pv.user_id
    AND lt.last_touch_at = pv.timestamp
)
SELECT lt_attr.utm_source,
       lt_attr.utm_campaign,
       COUNT(*) AS purchase_last_touches
FROM lt_attr
GROUP BY 1, 2
ORDER BY 3 DESC;

-- E. What is the typical user journey?
-- You can explore the most common sequences of page visits:
SELECT user_id, GROUP_CONCAT(page_name, ' -> ') AS journey
FROM page_visits
GROUP BY user_id
ORDER BY user_id
LIMIT 10;  