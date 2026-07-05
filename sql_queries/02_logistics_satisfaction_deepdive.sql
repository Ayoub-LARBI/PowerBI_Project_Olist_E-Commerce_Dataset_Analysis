WITH review_base AS (
    SELECT
        DATE_TRUNC('month', r.review_creation_date) AS month_date,
        TO_CHAR(DATE_TRUNC('month', r.review_creation_date), 'Mon YYYY') AS month_name,
        EXTRACT(YEAR FROM r.review_creation_date) AS year,
        r.review_score,
        COALESCE(t.product_category_name_english, p.product_category_name) AS review_category,
        COUNT(*) AS segment_reviews,
        COUNT(r.review_comment_message) AS segment_reviews_with_comments
    FROM order_reviews r
    LEFT JOIN order_items oi ON r.order_id = oi.order_id
    LEFT JOIN products p ON oi.product_id = p.product_id
    LEFT JOIN product_category_name_translation t ON p.product_category_name = t.product_category_name
    GROUP BY DATE_TRUNC('month', r.review_creation_date), TO_CHAR(DATE_TRUNC('month', r.review_creation_date), 'Mon YYYY'), 3, 4, 5
),
monthly_weighted_satisfaction AS (
    SELECT 
        DATE_TRUNC('month', r.review_creation_date) AS month_date,
        ROUND(AVG(r.review_score), 2) AS true_monthly_avg
    FROM order_reviews r
    GROUP BY 1
),
category_weighted_satisfaction AS (
    SELECT
        COALESCE(t.product_category_name_english, p.product_category_name) AS review_category,
        ROUND(AVG(r.review_score), 2) AS true_category_avg
    FROM order_reviews r
    LEFT JOIN order_items oi ON r.order_id = oi.order_id
    LEFT JOIN products p ON oi.product_id = p.product_id
    LEFT JOIN product_category_name_translation t ON p.product_category_name = t.product_category_name
    GROUP BY 1
    HAVING COUNT(r.review_id) >= 50
),
delivery_impact AS (
    SELECT
        CASE
            WHEN o.order_delivered_customer_date <= o.order_estimated_delivery_date THEN 'On Time'
            ELSE 'Late'
        END AS delivery_status,
        ROUND(AVG(r.review_score), 2) AS avg_score_by_delivery
    FROM orders o
    JOIN order_reviews r ON o.order_id = r.order_id
    WHERE o.order_delivered_customer_date IS NOT NULL
    GROUP BY 1
),
global_review_metrics AS (
    SELECT
        ROUND(AVG(review_score), 2) AS global_avg_review_score,
        ROUND(COUNT(review_comment_message) * 100.0 / COUNT(*), 2) AS global_comment_rate
    FROM order_reviews
)
SELECT
    rb.month_date,
    rb.month_name AS month,
    rb.year,
    rb.review_score,
    COALESCE(rb.review_category, 'Unknown / Uncategorized') AS review_category,
    rb.segment_reviews,
    rb.segment_reviews_with_comments,
    mws.true_monthly_avg,
    COALESCE(cws.true_category_avg, 4.09) AS true_category_avg,
    di_ot.avg_score_by_delivery AS avg_score_on_time,
    di_lt.avg_score_by_delivery AS avg_score_late,
    gr.global_avg_review_score,
    gr.global_comment_rate
FROM review_base rb
JOIN monthly_weighted_satisfaction mws ON rb.month_date = mws.month_date
LEFT JOIN category_weighted_satisfaction cws ON rb.review_category = cws.review_category
CROSS JOIN global_review_metrics gr
LEFT JOIN delivery_impact di_ot ON di_ot.delivery_status = 'On Time'
LEFT JOIN delivery_impact di_lt ON di_lt.delivery_status = 'Late'