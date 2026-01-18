select
    nullif(trim(product_id), '') as product_id,
    nullif(trim(product_name), '') as product_name,
    nullif(trim(category), '') as category,
    nullif(trim(subcategory), '') as subcategory,
    nullif(trim(brand), '') as brand,
    nullif(trim(sku), '') as sku,
    unit_price,
    cost_price,
    stock_quantity,
    nullif(trim(warehouse_location), '') as warehouse_location,
    nullif(trim(status), '') as status,
    nullif(trim(weight), '') as weight,
    nullif(trim(dimensions), '') as dimensions,
    created_date,
    last_updated,
    nullif(trim(is_hazardous), '') as is_hazardous,
    load_timestamp,
    source_file
from {{ source('bronze', 'bronze_inventory_master') }}
where product_id is not null
