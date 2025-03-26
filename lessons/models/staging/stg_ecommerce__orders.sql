-- pasted the results of the generate_base_model macro:
-- dbt run-operation generate_base_model --args '{"source_name": "thelook_ecommerce", "table_name": "orders"}'

WITH source AS (
    SELECT *
    FROM {{ source('thelook_ecommerce', 'orders') }}
)

SELECT
    --IDs
    order_id,
    user_id,

    --Timestamps
    created_at,
    returned_at,
    shipped_at,
    delivered_at,

    --Other columns
    status,
    num_of_item AS num_items_ordered

    {#- Unused columns:
	    - gender
	#}


FROM source