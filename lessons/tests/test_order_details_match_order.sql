{{config(severity = 'warn')}}
/*
compares two sources:
- stg_ecommerce__order_items
and
- stg_ecommerce__orders
in terms of the number of items ordered.

(for any order, the number of line items in the order_items table
matches the num_items_ordered column in the orders table)

IDEA: if the query is not empty (any rows returned), throw an error
*/

WITH order_details AS
(
        SELECT
        order_id,
        COUNT(*) AS num_of_items_in_order
        FROM
        --if we add reference to the model =>
        --the test will be run whenever the model is created
        {{ref('stg_ecommerce__order_items')}}
        GROUP BY order_id
)

SELECT
    --returning rows you need to debug the issue:
    o.order_id,
    o.num_items_ordered,
    od.num_of_items_in_order

--this way, we don't trigger the test when testing the stg_ecommerce__orders
FROM  {{target.schema}}.`stg_ecommerce__orders` AS o
FULL OUTER JOIN order_details AS od USING(order_id)

--we want SQL to return some rows if anything's wrong, namely:
WHERE
    -- all orders should have at least 1 item
    -- and every item should tie to an order
    o.order_id IS NULL
    OR od.order_id IS NULL
    -- number of items doesn't match
    OR o.num_items_ordered != od.num_of_items_in_order
