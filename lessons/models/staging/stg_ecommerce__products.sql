WITH source AS (
        SELECT *
        FROM {{ source('thelook_ecommerce', 'products') }}
)

SELECT
    --IDs
    id AS product_id,

    --Other columns
    cost,
    retail_price,
    department

	{#- Unused columns:
        - brand
		- inventory_item_id
		- distribution_center_id
		- category
		- sku
		- name
	#}

FROM source