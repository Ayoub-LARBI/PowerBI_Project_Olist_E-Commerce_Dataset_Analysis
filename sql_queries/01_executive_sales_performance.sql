WITH item_revenue_booked AS (
    SELECT
        DATE_TRUNC('month', o.order_purchase_timestamp) AS month_date,
        TO_CHAR(DATE_TRUNC('month', o.order_purchase_timestamp), 'Mon YYYY') AS month_name,
        EXTRACT(YEAR FROM o.order_purchase_timestamp) AS year,
        o.order_status,
        COALESCE(t.product_category_name_english, p.product_category_name) AS category,
        SUM(oi.price + oi.freight_value) AS revenue,
        COUNT(DISTINCT o.order_id) AS total_orders
    FROM orders o
    LEFT JOIN order_items oi ON o.order_id = oi.order_id
    LEFT JOIN products p ON oi.product_id = p.product_id
    LEFT JOIN product_category_name_translation t ON p.product_category_name = t.product_category_name
    GROUP BY DATE_TRUNC('month', o.order_purchase_timestamp), TO_CHAR(DATE_TRUNC('month', o.order_purchase_timestamp), 'Mon YYYY'), 3, 4, 5
),
monthly_totals AS (
    SELECT 
        month_date,
        SUM(revenue) AS total_monthly_revenue
    FROM item_revenue_booked
    GROUP BY month_date
),
monthly_cumulative AS (
    SELECT 
        month_date,
        SUM(total_monthly_revenue) OVER (ORDER BY month_date) AS cumulative_revenue
    FROM monthly_totals
),
global_metrics AS (
    SELECT
        ROUND(SUM(payment_value) / COUNT(DISTINCT order_id), 0) AS avg_order_value
    FROM order_payments
)
SELECT
    r.month_date,
    r.month_name AS month,
    r.year,
    r.order_status,
    COALESCE(r.category, 'Unknown / Uncategorized') AS category,
    ROUND(r.revenue, 0) AS revenue,
    r.total_orders,
    ROUND(c.cumulative_revenue, 0) AS cumulative_revenue,
    g.avg_order_value
FROM item_revenue_booked r
JOIN monthly_cumulative c ON r.month_date = c.month_date
CROSS JOIN global_metrics g